return {
    {
        'stevearc/conform.nvim',
        lazy = true,
        event = 'BufWritePre',
        cmd = 'ConformInfo',
        opts = {
            formatters_by_ft = {
                c = { 'clang-format' },
                cpp = { 'clang-format' },
                lua = { 'stylua' },
                nix = { 'nixfmt' },
                python = function(bufnr)
                    if require('conform').get_formatter_info('ruff_format', bufnr).available then
                        return { 'ruff_format' }
                    else
                        return { 'isort', 'black' }
                    end
                end,
                rust = { 'rustfmt' },
                tex = { 'tex-fmt' },
                toml = { 'tombi' },
                yaml = { 'yamlfmt' },
                zig = { 'zigfmt' },
                -- filetypes without formatters: format with LSP, then fix typos
                ['_'] = { 'typos', lsp_format = 'first' },
            },
            default_format_opts = {
                lsp_format = 'fallback',
            },
            format_on_save = {
                lsp_format = 'fallback',
                timeout_ms = 500,
            }
        }
    }
}
