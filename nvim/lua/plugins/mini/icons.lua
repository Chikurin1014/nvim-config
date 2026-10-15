return {
    'nvim-mini/mini.icons',
    lazy = true,
    config = true,
    init = function()
        -- Use mini.icons for plugins that depend on nvim-web-devicons
        package.preload['nvim-web-devicons'] = function()
            require('mini.icons').mock_nvim_web_devicons()
            return package.loaded['nvim-web-devicons']
        end
    end,
}
