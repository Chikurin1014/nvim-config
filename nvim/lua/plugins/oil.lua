return {
    {
        'stevearc/oil.nvim',
        -- Optional dependencies
        specs = { { 'nvim-mini/mini.icons', lazy = true } },
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
        keys = {
            {
                '<leader>oe',
                function() require('utils.oil').open_with_preview() end,
                mode = 'n',
                desc = 'Open Oil explorer'
            },
        },
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
            keymaps = {
                ["<CR>"] = { "actions.select", mode = 'n' },
                ["<leader>v"] = { "actions.select", mode = 'n', opts = { vertical = true } },
                ["<leader>s"] = { "actions.select", mode = 'n', opts = { horizontal = true } },
                ["<leader>t"] = { "actions.select", mode = 'n', opts = { tab = true } },
                ["<leader>p"] = { "actions.preview", mode = 'n' },
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<leader>r"] = { "actions.refresh", mode = "n" },
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["g~"] = { "actions.cd", mode = "n", opts = { scope = "tab" } },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = { "actions.open_external", mode = "n" },
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
                ["g?"] = { "actions.show_help", mode = "n" },
            },
            use_default_keymaps = false,
        },
    },
}
