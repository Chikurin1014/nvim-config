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

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = false }),
                pattern = '*',
                callback = function ()
                    -- Do not start treesitter if the buffer is not a file
                    if vim.bo.buftype ~= '' then return end

                    local ft = vim.filetype.match { buf = 0 }
                    treesitter.install(ft)
                    vim.treesitter.start()

                    -- Treesitter-based folding
                    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo[0][0].foldmethod = 'expr'

                    -- Treesitter-based indentation
                    vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
                end
            })
        end
    }
}
