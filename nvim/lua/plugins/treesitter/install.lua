return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        lazy = false,
        config = function ()
            local treesitter = require 'nvim-treesitter'

            treesitter.setup { install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter') }

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = false }),
                pattern = '*',
                callback = function (opts)
                    local ft = vim.bo[opts.buf].filetype
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
