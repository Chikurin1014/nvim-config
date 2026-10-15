local building = 0
local saved_cl ---@type string?

--- Run a parser install/update task of nvim-treesitter.
--- On Windows, MSVC takes minutes to compile large parsers (e.g. gitcommit) with optimizations,
--- and an interrupted build makes the next install fail (`Could not rename temp: EPERM`).
--- So disable optimizations while building (`_CL_` is appended to the options of cl.exe).
---@param fn fun(): async.Task
---@return async.Task
local function build_parsers(fn)
    if vim.fn.has('win32') == 0 then
        return fn()
    end

    if building == 0 then
        saved_cl = vim.env._CL_
        vim.env._CL_ = vim.trim((saved_cl or '') .. ' /Od')
    end
    building = building + 1

    local task = fn()
    task:await(function ()
        vim.schedule(function ()
            building = building - 1
            if building == 0 then
                vim.env._CL_ = saved_cl
            end
        end)
    end)
    return task
end

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = function ()
            build_parsers(function () return require('nvim-treesitter').update() end)
        end,
        lazy = false,
        config = function ()
            local treesitter = require 'nvim-treesitter'

            treesitter.setup { install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter') }
            build_parsers(function () return treesitter.install { 'gitcommit' } end)

            local available = {} ---@type table<string, boolean>
            for _, lang in ipairs(treesitter.get_available()) do
                available[lang] = true
            end

            ---@param buf integer
            ---@param lang string
            local function start(buf, lang)
                if not vim.api.nvim_buf_is_valid(buf) then return end
                if not pcall(vim.treesitter.start, buf, lang) then return end

                -- Treesitter-based folding
                for _, win in ipairs(vim.fn.win_findbuf(buf)) do
                    vim.wo[win][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo[win][0].foldmethod = 'expr'
                end

                -- Treesitter-based indentation
                vim.bo[buf].indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
            end

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
                pattern = '*',
                callback = function (args)
                    -- Do not start treesitter if the buffer is not a file
                    if vim.bo[args.buf].buftype ~= '' then return end

                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang or not available[lang] then return end

                    if vim.treesitter.language.add(lang) then
                        start(args.buf, lang)
                        return
                    end

                    -- Install the parser asynchronously, then start
                    build_parsers(function () return treesitter.install(lang) end):await(function (err)
                        if err then return end
                        vim.schedule(function () start(args.buf, lang) end)
                    end)
                end
            })
        end
    }
}
