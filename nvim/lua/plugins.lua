local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
    -- "dstein64/vim-startuptime",
    -- "nathom/filetype.nvim",

    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",

    "neovim/nvim-lspconfig",
    "nvimdev/lspsaga.nvim",
    
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "OrangeLightning219/nvim-cmp",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "hrsh7th/vim-vsnip-integ",

    "nvim-tree/nvim-web-devicons",
    { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "MunifTanjim/nui.nvim" } },
    "nvim-lualine/lualine.nvim",

    { "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim",  build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },

    "kdheepak/lazygit.nvim",
    "lewis6991/gitsigns.nvim",

    "terrortylor/nvim-comment",
    "folke/todo-comments.nvim",
    "Raimondi/delimitMate",
    "rhysd/vim-clang-format",

    -- "rcarriga/nvim-notify",

    { 'rose-pine/neovim', name = 'rose-pine' },

    -- "OrangeLightning219/automaton.nvim",
    "Dax89/automaton.nvim",

    {
        "coffebar/neovim-project",
        init = function()
          vim.opt.sessionoptions:append("globals")
        end,
        dependencies = { { "Shatur/neovim-session-manager" } },
        lazy = false,
        priority = 100,
    },
    
    "stevearc/conform.nvim",
    "unblevable/quick-scope"
    -- "luckasRanarison/tailwind-tools.nvim",
}

options = {}

require("lazy").setup(plugins, options)