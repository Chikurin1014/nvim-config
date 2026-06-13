return {
    {
        'williamboman/mason-lspconfig.nvim',
        specs = {
            {
                'williamboman/mason.nvim',
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
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        lazy = true,
        event = 'FileType',
        opts = {        },
    },
}
