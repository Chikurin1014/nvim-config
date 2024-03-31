return {
    {
        'sidebar-nvim/sidebar.nvim',
        config = function()
            require('sidebar-nvim').setup({
                open = true,
                side = 'right',
                initial_width = 35,
                sections = { 'git', 'containers', 'diagnostics' }
            })
        end
    }
}

