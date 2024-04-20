return {
    {
        'sidebar-nvim/sidebar.nvim',
        config = function()
            require('sidebar-nvim').setup({
                open = false,
                side = 'right',
                initial_width = 25,
                sections = { 'git', 'containers', 'diagnostics' }
            })
        end
    }
}

