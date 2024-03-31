return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            local bufferline = require('bufferline')
            bufferline.setup {
                options = {
                    mode = 'buffers',
                    style_preset = bufferline.style_preset.default,
                    numbers = 'none',
                    color_icons = true,
                    separator_style = 'slant'
                },
            }
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }
            map('n', '<leader>k', '<cmd>BufferLineCycleNext<cr>', opts)
            map('n', '<leader>j', '<cmd>BufferLineCyclePrev<cr>', opts)
            map('n', '<leader>,', '<cmd>BufferLinePick<cr>', opts)
            map('n', '<leader>ek', '<cmd>BufferLineCloseRight<cr>', opts)
            map('n', '<leader>ej', '<cmd>BufferLineCloseLeft<cr>', opts)
        end
    }
}

