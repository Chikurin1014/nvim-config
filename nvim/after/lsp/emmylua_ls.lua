return {
    workspace_required = true,
    -- Settings are sent before `on_init`, so this must be done in `before_init`
    before_init = function(_, config)
        -- If the workspace has its own emmylua_ls/lua_ls config file, defer to it.
        local root = config.root_dir
        if
            root
            and root ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(root .. '/.emmyrc.json') or vim.uv.fs_stat(root .. '/.luarc.json'))
        then
            config.settings.emmylua.runtime = nil
            config.settings.emmylua.workspace = nil
        end
    end,
    -- emmylua_ls reads the `emmylua` section and ignores the `Lua` section provided by lazydev.nvim,
    -- so pass the Neovim runtime and plugins here (`VIMRUNTIME` and `stdpath` work on every OS).
    settings = {
        emmylua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy'),
                },
            },
        },
    },
}
