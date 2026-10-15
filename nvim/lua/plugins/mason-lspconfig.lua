return {
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
            'neovim/nvim-lspconfig',
        },
        lazy = true,
        event = 'FileType',
        opts = {},
    },
}
