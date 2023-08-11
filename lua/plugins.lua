vim.cmd.packadd 'packer.nvim'

require('packer').startup(function()
    -- 起動時に読み込むプラグインを書いてください。
    use { 'wbthomason/packer.nvim' }
    use { 'neoclide/coc.nvim', branch = 'release' }

    use { 'lambdalisue/fern.vim' }
    use {
        'lambdalisue/fern-renderer-nerdfont.vim',
        requires = { 'lambdalisue/nerdfont.vim', opt = true }
    }

    use { 'nvim-treesitter/nvim-treesitter' }

    use { 'romgrk/barbar.nvim' }

    use { 'dinhhuy258/git.nvim' }
    use { 'lewis6991/gitsigns.nvim' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use { 'nvim-tree/nvim-web-devicons' }
    use { 'lambdalisue/nerdfont.vim' }
end)
