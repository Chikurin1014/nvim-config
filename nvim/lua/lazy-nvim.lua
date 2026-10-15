return {
    setup = function()
        local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
        if not vim.uv.fs_stat(lazypath) then
            local out = vim.fn.system {
                'git',
                'clone',
                '--filter=blob:none',
                'https://github.com/folke/lazy.nvim.git',
                '--branch=stable', -- latest stable release
                lazypath,
            }
            if vim.v.shell_error ~= 0 then
                vim.api.nvim_echo({
                    { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
                    { out,                            'WarningMsg' },
                }, true, {})
                return
            end
        end
        vim.opt.rtp:prepend(lazypath)

        require('lazy').setup {
            spec = {
                { import = 'plugins' },
                { import = 'plugins.mini' },
                { import = 'plugins.snacks' },
                { import = 'plugins.treesitter' },
                { import = 'plugins.ui' },
                { import = 'plugins.util' }
            },
            pkg = {
                sources = { 'lazy', 'rockspec', 'packspec' },
            },
            rocks = { enabled = true },
        }
    end,
}
