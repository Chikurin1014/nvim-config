return {
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        keys = {
            {
                '<leader>of',
                function ()
                    Snacks.explorer.open()
                end,
                mode = 'n',
                desc = 'Open explorer-like picker'
            },
            {
                '<leader>ot',
                function ()
                    Snacks.terminal.open()
                end,
                mode = 'n',
                desc = 'Open terminal window'
            },
            {
                '<leader>tt',
                function ()
                    Snacks.terminal.toggle()
                end,
                mode = 'n',
                desc = 'Toggle terminal window'
            },
            {
                '<leader>tz',
                function ()
                    Snacks.zen()
                end,
                mode = 'n',
                desc = 'Toggle zen mode'
            },
            {
                '<leader>os',
                function ()
                    Snacks.scratch()
                end,
                mode = 'n',
                desc = 'Open scratch buffer'
            },
            {
                '<leader>s',
                function ()
                    Snacks.scratch.select()
                end,
                mode = 'n',
                desc = 'Find scratch buffer'
            }
        },
        opts = {
            bigfile = { enabled = true },
            explorer = { replace_netrw = false },
            image = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            terminal = { shell = vim.g.shell },
            words = { enabled = true }
        },
        init = function ()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'VeryLazy',
                callback = function ()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function (...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function ()
                        Snacks.debug.backtrace()
                    end
                    -- Override print to use snacks for `:=` command
                    if vim.fn.has('nvim-0.11') == 1 then
                        vim._print = function (_, ...)
                            dd(...)
                        end
                    else
                        vim.print = dd
                    end
                end
            })

            -- Integration with Oil.nvim
            vim.api.nvim_create_user_autocmd('User', {
                pattern = 'OilActionPost',
                callback = function (event)
                    if event.data.actions[1].type == 'move' then
                        Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
                    end
                end
            })
        end
    }
}
