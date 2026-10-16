-- Need to tell neovim where the LSPs installed by mise are
-- ref: https://mise.jdx.dev/ide-integration.html#neovim
local mise_data_dir = vim.env.MISE_DATA_DIR
    or vim.g.is_unix and vim.fs.joinpath(vim.env.XDG_DATA_HOME or vim.fs.joinpath(vim.env.HOME, '.local', 'share'), 'mise')
    or vim.fs.joinpath(vim.env.LOCALAPPDATA, 'mise')
local mise_shims = vim.fs.joinpath(mise_data_dir, 'shims')
if vim.uv.fs_stat(mise_shims) then
    vim.env.PATH = mise_shims .. (vim.g.is_unix and ':' or ';') .. vim.env.PATH
end

vim.lsp.config('*', {
    root_markers = { '.git' }
})
vim.lsp.enable({
    'copilot',
    'markdown_oxide',
    'nixd'
})
