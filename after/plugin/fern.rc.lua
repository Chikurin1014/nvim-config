vim.g["fern#renderer"] = "nerdfont"
vim.cmd([[
    set guifont=FirgeNerd
]])

vim.g["fern#default_hidden"] = true

-- vim.cmd([[
-- augroup my-glyph-palette
--   autocmd! *
--   autocmd FileType fern call glyph_palette#apply()
--   autocmd FileType nerdtree,startify call glyph_palette#apply()
-- augroup END
-- ]])

vim.g["fern#drawer_width"] = 35
vim.keymap.set('n', '<C-n>', ':Fern . -drawer -toggle -reveal=%<CR>', { silent = true, noremap = true })

-- 下記の記述はtrash-cliを用いない場合にファイル等を削除する方法
-- ただし内部的には $ rm のため、原則使わない

-- function! s:fern_settings() abort
--   nmap <silent> <buffer> dd <Plug>(fern-action-remove)
-- endfunction

-- augroup fern-settings
--   autocmd!
--   autocmd FileType fern call s:fern_settings()
-- augroup END
