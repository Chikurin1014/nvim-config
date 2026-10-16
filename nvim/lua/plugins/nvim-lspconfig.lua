return {
    {
        'neovim/nvim-lspconfig',
        -- `vim.lsp.enable()` in lua/lsp.lua resolves configs on the first FileType,
        -- so lspconfig's lsp/*.lua must be on the runtimepath before that.
        -- Otherwise only after/lsp/*.lua is found and the config lacks `cmd`.
        lazy = false,
    },
}
