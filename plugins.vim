call plug#begin('E:/neovim-config/nvim/autoload')

Plug 'arzg/vim-colors-xcode'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'

Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'

Plug 'mhinz/vim-startify'

call plug#end()

lua << EOF
return require('packer').startup(function()
    use({
        'Deathbat2190/neovim-rose-pine-theme',
        as = 'rose-pine',
        config = function()
            -- Options (see available options below)
            vim.g.rose_pine_variant = 'moon'
            vim.g.rose_pine_disable_italics = true

            -- Load colorscheme after options
            vim.cmd('colorscheme rose-pine')
        end
    })
end)
EOF