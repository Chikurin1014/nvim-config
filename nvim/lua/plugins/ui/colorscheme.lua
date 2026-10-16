local function import_theme(plugin, mod, options)
    options = options or {}
    local themes = options.themes or { mod }
    local default = vim.g.default_colorscheme
    local contains_default = vim.tbl_contains(themes, default)
    local theme_mod = 'plugins.ui.themes.' .. mod
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
        enabled = options.enabled or specs.enabled or contains_default,
        -- Load the default colorscheme at startup to avoid flickering.
        -- Others are loaded by lazy.nvim on `:colorscheme` automatically.
        lazy = not contains_default,
        priority = contains_default and 1000 or nil,
        event = not contains_default and { 'CursorHold' } or nil,
        opts = vim.tbl_deep_extend('force', specs.opts or {}, options.opts or {}),
        config = specs.config
            or function (_, opts)
                require(specs.main or mod).setup(opts)
                if contains_default then
                    vim.cmd.colorscheme(default)
                end
            end
    }
end

return {
    import_theme(
        'rebelot/kanagawa.nvim', 'kanagawa',
        {
            enabled = true,
            themes = { 'kanagawa', 'kanagawa-dragon', 'kanagawa-lotus' }
        }
    ),
    import_theme('EdenEast/nightfox.nvim', 'nightfox', {
        enabled = true,
        themes = { 'nightfox', 'nordfox', 'duskfox', 'dayfox', 'terafox', 'carbonfox' }
    })
}
