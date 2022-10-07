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

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.0' })
Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'pianocomposer321/yabs.nvim'

Plug 'TimUntersberger/neogit'

Plug 'kalvinpearce/ShaderHighlight'

Plug 'Raimondi/delimitMate'

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