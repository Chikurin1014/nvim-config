return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        lazy = false,
        config = function ()
            local treesitter = require 'nvim-treesitter'

            treesitter.setup { install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter') }
            treesitter.install { "gitcommit" }

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
                    if vim.tbl_contains({ 'oil' }, args.match) then return end

                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang or not available[lang] then return end

                    if vim.treesitter.language.add(lang) then
                        start(args.buf, lang)
                        return
                    end

                    -- Install the parser asynchronously, then start
                    treesitter.install(lang):await(function (err)
                        if err then return end
                        vim.schedule(function () start(args.buf, lang) end)
                    end)
                end
            })
        end
    }
}
