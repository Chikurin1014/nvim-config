local function import_theme(plugin, mod, options)
    options = options or {}
    local theme = options.theme or mod
    local is_default = theme == vim.g.default_colorscheme
    local theme_mod = 'plugins.ui.themes.' .. theme
    local ok, specs = pcall(require, theme_mod)
    if not ok then
        -- Theme files are optional, but errors inside them should not be hidden
        if not specs:find(("module '%s' not found"):format(theme_mod), 1, true) then
            error(specs)
        end
        specs = {}
    end
    return {
        plugin,
        enabled = options.enabled or specs.enabled or is_default,
        -- Load the default colorscheme at startup to avoid flickering.
        -- Others are loaded by lazy.nvim on `:colorscheme` automatically.
        lazy = not is_default,
        priority = is_default and 1000 or nil,
        event = not is_default and 'CursorHold' or nil,
        opts = vim.tbl_deep_extend('force', specs.opts or {}, options.opts or {}),
        config = specs.config
            or function(_, opts)
                require(specs.main or mod).setup(opts)
                if is_default then
                    vim.cmd.colorscheme(theme)
                end
            end,
    }
end

return {
    import_theme('rebelot/kanagawa.nvim', 'kanagawa', { enabled = true }),
    import_theme('EdenEast/nightfox.nvim', 'nightfox', { enabled = true }),
}
