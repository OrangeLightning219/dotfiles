require("settings")
require("plugins")

require("autocomplete_config")
require("lualine_config")
require("tree-sitter_config")
require("nvim-tree_config")
require("nvim-comment_config")
require("todo_config")
require("telescope").setup()
require("sessions_config")
require("rose-pine_config")
require("yabs_config")

require("indent_blankline").setup({
    show_first_indent_level = false,
})
require("gitsigns").setup()