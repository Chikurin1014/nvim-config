local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
    ensure_installed = {
        "c",
        "cpp",
        "rust",
        "python",
        "bash",
    },
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}
