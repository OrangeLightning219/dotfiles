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
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",

    { 'OrangeLightning219/blink.cmp', branch = "v1", build = "cargo build --release", dev = false },

    "OrangeLightning219/automaton.nvim",

    "stevearc/conform.nvim",

    { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "MunifTanjim/nui.nvim" } },

    "nvim-lualine/lualine.nvim",

    { "nvim-telescope/telescope.nvim", tag = "v0.2.1", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },

    "kdheepak/lazygit.nvim",
    "lewis6991/gitsigns.nvim",

    { "coffebar/neovim-project", dependencies = { { "Shatur/neovim-session-manager" } }, lazy = false, priority = 100 },

    "terrortylor/nvim-comment",
    "folke/todo-comments.nvim",
    "Raimondi/delimitMate",

    "unblevable/quick-scope",
    "nvim-tree/nvim-web-devicons",

    { 'rose-pine/neovim', name = 'rose-pine' },
}

-- local options = {
--     dev = {
--         path = "E:/Misc",
--         -- patterns = {"automaton.nvim"},
--         patterns = {"blink.cmp"},
--         fallback = false
--     }
-- }

require("lazy").setup(plugins, options)