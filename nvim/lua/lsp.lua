vim.lsp.config('*', {
    root_markers = { '.git' }
})
vim.lsp.enable({
    'copilot',
    'markdown_oxide',
    'nixd'
})
