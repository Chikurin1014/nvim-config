return {
    {
        'folke/which-key.nvim',
        lazy = true,
        event = { 'VeryLazy' },
        cmd = { 'WhichKey' },
        keys = {
            {
                '<F1>',
                function()
                    require('which-key').show({ global = true })
                end,
                mode = 'n',
                noremap = true,
                silent = true
            }
        },
        opts = {
            preset = 'helix',
            -- Groups of key mappings (descriptions only)
            spec = {
                { '<leader>g', group = 'Git' },
                { '<leader>j', group = 'Jump' },
                { '<leader>o', group = 'Open' },
                { '<leader>t', group = 'Toggle' },
                { '<leader>tg', group = 'Toggle git' },
            },
        },
        init = function()
            vim.opt.timeout = true
            vim.opt.timeoutlen = 100
        end
    }
}
