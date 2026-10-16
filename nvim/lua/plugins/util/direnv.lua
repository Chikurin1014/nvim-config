return {
    {
        'NotAShelf/direnv.nvim',
        -- Load `.envrc` even when Neovim is not started from a shell with the direnv hook (e.g. Neovide).
        -- direnv is not installed everywhere (e.g. Windows).
        cond = vim.fn.executable('direnv') == 1,
        -- Must be set up before `VimEnter` to load `.envrc` of the startup directory.
        lazy = false,
        opts = {
            autoload_direnv = true,
            -- `.envrc` is loaded asynchronously, so restart the language servers started before it is loaded
            auto_restart_lsp = true,
            -- The status cache is not per directory, so `:cd` within the TTL uses the status of the previous directory
            cache_ttl = 0,
            -- `<leader>d` is used by CodeDiff. Use `:Direnv allow|deny|reload|edit` instead.
            keybindings = false,
        },
    },
}
