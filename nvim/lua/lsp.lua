vim.lsp.config('*', {
    root_markers = { '.git/' },
})
vim.lsp.enable({
    'copilot',
    'marksman',
    'nixd',
})
