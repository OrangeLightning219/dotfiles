require("settings")
require("plugins")

require("autocomplete_config")
require("telescope").setup()

-- =================================================================================

require("nvim-treesitter.install").compilers = { "cl", "clang", "gcc" }

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.jai = {
    install_info = {
        url = "https://github.com/adragomir/tree-sitter-jai", 
        files = {"src/parser.c", "src/scanner.cc"},
    },
    filetype = "jai", 
}

vim.treesitter.language.register("jai", "jai")

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "c", "cpp", "bash", "cmake", "cuda", "dockerfile", "glsl", "html", "jai",
        "java", "javascript", "json", "lua", "make", "markdown", "python", "vim", "yaml"
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
    playground = {
        enable = true,
    }
}

-- =================================================================================

-- require("nvim-tree").setup({
--     disable_netrw = true,
--     hijack_cursor = true,
--     hijack_unnamed_buffer_when_opening = true,
--     sync_root_with_cwd = true,
--     view = {
--         width = "17%",
--     },
--     renderer = {
--         highlight_git = true,
--     },
-- })

-- =================================================================================

local function handle_nvim_tree()
    -- nvim_tree = require("nvim-tree.api")
    -- for i, buffer in ipairs(vim.api.nvim_list_bufs()) do
    --     if vim.api.nvim_buf_is_loaded(buffer) and nvim_tree.tree.is_tree_buf(buffer) then
    --         nvim_tree.tree.open()
    --     end
    -- end
end

require("auto-session").setup({
    auto_save_enabled = true,
    post_restore_cmds = {handle_nvim_tree}
})

require("telescope").load_extension("session-lens")

-- =================================================================================

local pallete = require('rose-pine.palette')
pallete.pine = '#8981d6'

require('rose-pine').setup({
	dark_variant = 'moon',
	disable_italics = true,

	highlight_groups = {
        Macro = {fg = 'rose'},
        ['@constant'] = {fg = 'iris'},
        Constant = {fg = 'iris'},
        ['@constructor'] = {fg = 'rose'},
        ['@keyword'] = {fg = pallete.pine},
        Keyword    = {fg = pallete.pine},
        ['@repeat'] = {fg = pallete.pine},
        ['@conditional'] = {fg = pallete.pine},
        ['@operator'] = {fg = pallete.pine},
        Operator = {fg = pallete.pine},
        ['@delimiter'] = {fg = 'muted'},
        ['@keyword.operator'] = {fg = pallete.pine},
        ['@boolean'] = {fg = pallete.pine},
        ['@include'] = {fg = pallete.pine},
        ['@string.escape'] = {fg = pallete.pine},
        TelescopeMatching = {fg = 'gold'},
        TelescopeNormal = {fg = 'text'}
	}
})

vim.cmd('colorscheme rose-pine')

-- =================================================================================

local jai_exe = "jai"
if vim.fn.has("macunix") then
    jai_exe = "jai-macos"
end

require("yabs"):setup({
  languages = {
    jai = {
      default_task = "build",
      tasks = {
        build = {
          command = jai_exe .. " ./first.jai",
          output = "quickfix", 
          opts = { open_on_run = "auto" },
        },
      }
    }
  },
  tasks = { -- Same values as `language.tasks`, but global
    build = {
      command = jai_exe .. " ./first.jai",
      output = "quickfix",
      opts = { open_on_run = "auto" },
    }
  },
})

-- =================================================================================

require("nvim_comment").setup({ comment_empty = false })
require("indent_blankline").setup({ show_first_indent_level = false })
require("gitsigns").setup()
require("lualine").setup({ options = { theme = "material" }})
require("todo-comments").setup({
    keywords = {
        PERF = { alt = { "PERFORMANCE", "OPTIMIZE", "MEMORY" } },
    },
})