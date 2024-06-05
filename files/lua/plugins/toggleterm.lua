return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {},
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = {}
            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
            function _lazygit_toggle()
                lazygit:toggle()
            end
            map('n', '<leader>t', '<CMD>lua _lazygit_toggle()<CR>', opts)
        end
    }
}
