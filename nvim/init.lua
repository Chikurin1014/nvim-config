-- Enable config cache (before requiring any modules)
vim.loader.enable()

-- Options and keymaps must be set before lazy.nvim loads plugins (e.g. `mapleader`)
require('base')
require('keymaps')
require('lsp')
if vim.g.neovide then
    require('neovide')
end

require('lazy-nvim').setup()
