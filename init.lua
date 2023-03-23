require("plugins")

require("autocomplete_config")
require("lualine_config")
require("tree-sitter_config")
require("nvim-tree_config")
require("neogit_config")
require("nvim-comment_config")
require("todo_config")
require("telescope_config")
require("rose-pine_config")
require("yabs_config")
-- require("nvim-cpp").setup()

vim.opt.runtimepath:append("E:/Projects/nvim-jai") -- for development
dofile("E:/Projects/nvim-jai/lua/nvim-jai.lua").setup({port = "6969"})

-- vim.cmd("source $XDG_CONFIG_HOME/nvim/jai_compile.vim")

-- require("nvim-jai").setup()

require("settings")
