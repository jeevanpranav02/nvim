-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope for Fuzzy Finding
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {'nvim-telescope/telescope-media-files.nvim'}
    use {'nvim-lua/popup.nvim'}

    -- Theme
    use({
        'rose-pine/neovim',
        as = 'rose-pine'
    })
    vim.cmd('colorscheme rose-pine')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })

    -- Nvim Tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    -- Harpoon
    use 'ThePrimeagen/harpoon'

    -- UndoTree similar to GitBranches
    use("mbbill/undotree")

    -- For Pair Parenthesis
    use("windwp/nvim-autopairs")

    -- Git support
    use("tpope/vim-fugitive")

    -- Java DT Language Server
    use('mfussenegger/nvim-dap')
    use('mfussenegger/nvim-jdtls')

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = { -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = ":MasonUpdate"
            },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' } }
    }

end)
