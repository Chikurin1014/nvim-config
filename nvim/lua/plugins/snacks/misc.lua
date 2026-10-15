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
        -- NOTE: lazy.nvim merges specs of the same plugin and only the last `init` is used,
        -- so keep the only `init` of snacks.nvim here.
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
                    vim._print = function (_, ...)
                        dd(...)
                    end
                end
            })

            -- Integration with Oil.nvim
            vim.api.nvim_create_autocmd('User', {
                pattern = 'OilActionsPost',
                callback = function(event)
                    if event.data.actions[1].type == 'move' then
                        Snacks.rename.on_rename_file(event.data.actions[1].src_url,
                            event.data.actions[1].dest_url)
                    end
                end,
            })

            -- Show LSP progress with snacks.notifier
            ---@type table<number, { token: lsp.ProgressToken, msg: string, done: boolean } []>
            local progress = vim.defaulttable()
            vim.api.nvim_create_autocmd('LspProgress', {
                ---@param ev { data: { client_id: integer, params: lsp.ProgressParams } }
                callback = function (ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    local value = ev.data
                        .params
                        .value --[[@as {percentage?: number, title?: string, message?: string, kind: 'begin' | 'report' | 'end'}]]
                    if not client or type(value) ~= 'table' then
                        return
                    end
                    local p = progress[client.id]

                    for i = 1, #p + 1 do
                        if i == #p + 1 or p[i].token == ev.data.params.token then
                            p[i] = {
                                token = ev.data.params.token,
                                msg = ('[%3d%%] %s%s'):format(
                                    value.kind == 'end' and 100 or value.percentage or 100, value.title or '',
                                    value.message and (' **%s**'):format(value.message) or ''
                                ),
                                done = value.kind == 'end'
                            }
                            break
                        end
                    end

                    local msg = {} ---@type string[]
                    progress[client.id] = vim.tbl_filter(function (v)
                        return table.insert(msg, v.msg) or not v.done
                    end, p)

                    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
                    vim.notify(table.concat(msg, '\n'), 'info', {
                        id = 'lsp_progress',
                        title = client.name,
                        opts = function (notif)
                            notif.icon = #progress[client.id] == 0 and ' '
                                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end
                    })
                end
            })
        end
    }
}
