vim.cmd([[
nnoremap <silent> <space>s :Git<CR><C-w>T
nnoremap <silent> <space>b :Git blame<CR>
nnoremap <space>d :Gvdiffsplit master
nnoremap <silent> <space>w :Gwrite<CR>
]])
