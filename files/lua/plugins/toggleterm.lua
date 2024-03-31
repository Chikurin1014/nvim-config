return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {},
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = {}
            -- map('n', '<leader>w', '<cmd>ToggleTerm<cr>', opts)
        end
    }
}
