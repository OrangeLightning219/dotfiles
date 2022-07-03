local Plug = vim.fn['plug#']

vim.call('plug#begin', '$XDG_CONFIG_HOME/nvim/autoload')

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

-- Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'

Plug 'simrat39/symbols-outline.nvim'

Plug 'folke/trouble.nvim'

Plug 'tibabit/vim-templates'

Plug 'kalvinpearce/ShaderHighlight'

vim.call('plug#end')

local function packer_plugins()
    use('wbthomason/packer.nvim')

    use({ 'Deathbat2190/neovim-rose-pine-theme',
          as = 'rose-pine',
          config = function()
            -- Options (see available options below)
            vim.g.rose_pine_variant = 'moon'
            vim.g.rose_pine_disable_italics = true

            -- Load colorscheme after options
            vim.cmd('colorscheme rose-pine')
          end
        })

    use("terrortylor/nvim-comment")
end

require('packer').startup(packer_plugins)