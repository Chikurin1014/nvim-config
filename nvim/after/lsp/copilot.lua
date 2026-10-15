-- Suggest highlight
local function set_highlights()
    local hlc = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
    local hlm = vim.api.nvim_get_hl(0, { name = 'MoreMsg', link = false })
    vim.api.nvim_set_hl(0, 'ComplHint', vim.tbl_extend('force', hlc, { underline = true }))
    vim.api.nvim_set_hl(0, 'ComplHintMore', vim.tbl_extend('force', hlm, { underline = true }))
end

local function set_keymaps()
    -- Toggle inline completion
    vim.keymap.set('n', '<leader>tc', function()
        local enable = not vim.lsp.inline_completion.is_enabled()
        vim.lsp.inline_completion.enable(enable)
    end, { desc = 'Toggle copilot' }
    )

    -- Confirm with <C-y>
    vim.keymap.set('i', '<C-y>', function()
        if not vim.lsp.inline_completion.get() then
            return '<C-y>'
        end
    end, { expr = true, desc = 'Confirm copilot suggestion' }
    )

    -- <C-f>/<C-b>で補完候補を選択
    vim.keymap.set('i', '<C-f>', function()
        vim.lsp.inline_completion.select({ count = vim.v.count1 })
    end, { desc = 'Next copilot suggestion' }
    )
    vim.keymap.set('i', '<C-b>', function()
        vim.lsp.inline_completion.select({ count = -1 * vim.v.count1 })
    end, { desc = 'Previous copilot suggestion' }
    )
end

return {
    on_init = function()
        set_highlights()
        -- Colorschemes reset highlights, so apply them again
        vim.api.nvim_create_autocmd('ColorScheme', {
            group = vim.api.nvim_create_augroup('CopilotHighlight', { clear = true }),
            callback = set_highlights,
        })

        if vim.lsp.inline_completion then
            -- Enable inline completion
            vim.lsp.inline_completion.enable(true)
            set_keymaps()
        end
    end,
}
