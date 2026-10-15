return {
    {
        'smjonas/inc-rename.nvim',
        lazy = true,
        cmd = 'IncRename',
        keys = {
            { 'grn', ':IncRename ', mode = 'n', desc = 'rename symbol' }
        },
        opts = { input_buffer_type = 'snacks' },
    }
}
