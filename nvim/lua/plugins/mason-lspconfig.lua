return {
    {
        'neovim/nvim-lspconfig',
        -- `vim.lsp.enable()` in lua/lsp.lua resolves configs on the first FileType,
        -- so lspconfig's lsp/*.lua must be on the runtimepath before that.
        -- Otherwise only after/lsp/*.lua is found and the config lacks `cmd`.
        lazy = false,
    },
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            -- mason.nvim must be set up before mason-lspconfig.nvim
            {
                'mason-org/mason.nvim',
                lazy = true,
                cmd = {
                    "Mason",
                    "MasonInstall",
                    "MasonUninstall",
                    "MasonUninstallAll",
                    "MasonUpdate",
                    "MasonLog",
                },
                keys = {
                    { '<leader>om', '<cmd>Mason<cr>', desc = 'Open Mason' },
                },
                config = true,
            },
        },
        lazy = true,
        event = 'FileType',
        opts = {},
    },
}
