return {
    {
        -- maintained fork of norcalli/nvim-colorizer.lua
        'catgoose/nvim-colorizer.lua',
        lazy = true,
        -- lazy.nvim re-triggers `FileType` on load, so the current buffer is attached too
        event = { 'FileType' },
        opts = { filetypes = { '*' } },
    }
}
