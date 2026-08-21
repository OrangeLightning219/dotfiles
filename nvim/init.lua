require("settings")
require("plugins")

-- =================================================================================

require("rose-pine.config").options.dark_variant = "moon"
local pallete = require('rose-pine.palette')
pallete.pine = '#8981d6'
pallete.base = '#232136'

require('rose-pine').setup({
	dark_variant = 'moon',
	styles = {
        bold = false,
        italic = false,
        transparency = false,
    },

	highlight_groups = {
        Macro = {fg = 'rose'},
        ['@constant'] = {fg = pallete.iris, link = ""},
        ['@constructor'] = {fg = pallete.rose},
        ['@keyword'] = {fg = pallete.pine, link = ""},
        ['@field'] = {fg = pallete.text, link = ""},
        ['@repeat'] = {fg = pallete.pine, link = ""},
        ['@conditional'] = {fg = pallete.pine, link = ""},
        ['@exception'] = {fg = pallete.pine, link = ""},
        ['@operator'] = {fg = pallete.pine, link = ""},
        ['@delimiter'] = {fg = pallete.muted},
        ['@keyword.operator'] = {fg = pallete.pine},
        ['@keyword.directive'] = {fg = pallete.pine},
        ['@keyword.directive.define'] = {fg = pallete.pine},
        ['@keyword.import'] = {fg = pallete.pine},
        ['@keyword.return'] = {fg = pallete.pine},
        ['@boolean'] = {fg = pallete.pine},
        ['@include'] = {fg = pallete.pine},
        ['@string.escape'] = {fg = pallete.pine},
        ['@variable.member'] = {fg = pallete.text},
        ['@property'] = {fg = pallete.text},
        ['@module'] = {fg = pallete.foam},
        ['@function.method.call'] = {fg = pallete.rose},
        TelescopeMatching = {fg = pallete.gold},
        TelescopeNormal = {fg = pallete.text},
        StatusLineNC = {blend = 0},
        TreesitterContext = {bg = pallete.base},
        TreesitterContextLineNumber = {fg = pallete.muted, bg = pallete.base},
        -- TreesitterContextSeparator = {fg = pallete.muted, bg = pallete.base},
        TreesitterContextBottom = {underline = true, sp = pallete.muted},
        TreesitterContextLineNumberBottom = {underline = true, sp = pallete.muted},
	}
})

vim.cmd('colorscheme rose-pine')

-- =================================================================================
-- vim.lsp.set_log_level("debug")

-- vim.lsp.config["jails"] = {
--     cmd = { "jails" },
--     filetypes = { "jai" },
--     root_markers = { "jails.json" },
-- }
-- vim.lsp.enable("jails")

vim.lsp.config["clangd"] = {
    cmd = {"clangd", "--header-insertion=never"},
}
-- vim.lsp.enable("clangd")

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        }
    }
})

-- =================================================================================
require("blink.cmp").setup({
    keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        -- ["<Esc>"] = { "hide", "fallback" },
        ["<Esc>"] = {
            function ()
                require("blink.cmp").hide()
            end,
            "fallback"
        },
        ["<Enter>"] = { "accept", "fallback" },
        ["<C-Space>"] = { "show", "fallback" },
    },

    completion = {
        list = { selection = { auto_insert = false } },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = false },
        ghost_text = { enabled = true }
    },

    cmdline = {
        enabled = true,
        keymap = { 
            preset = "inherit",
            ["<Enter>"] = { "accept_and_enter", "fallback" },
        },
        sources = { "buffer", "cmdline" },
        completion = {
            list = { selection = { auto_insert = true, preselect = false } },
            menu = { auto_show = true }
        }
    },

    sources = { default = { "buffer", "path" } },
    fuzzy = { implementation = "rust" }
})

-- =================================================================================

require("nvim-treesitter.install").compilers = { "cl", "clang", "gcc" }

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.jai = {
    install_info = {
        url = "https://github.com/OrangeLightning219/tree-sitter-jai",
        -- url = "https://github.com/constantitus/tree-sitter-jai",
        branch = "less_broken",
        -- url = "https://github.com/adragomir/tree-sitter-jai", 
        files = {"src/parser.c", "src/scanner.c"},
    },
    filetype = "jai", 
}

parser_config.shader = {
    install_info = {
        -- url = vim.fs.normalize("F:/Jai_Projects/roguelike/src/misc/treesitter-shader"),
        url = "https://github.com/OrangeLightning219/treesitter-shader",
        branch = "main",
        files = {"src/parser.c", "src/scanner.c"},
    },
    filetype = "shader",
}

vim.filetype.add({
    extension = {
        shader = "shader",
    },
})

vim.treesitter.language.register("jai", "jai")
vim.treesitter.language.register("shader", "shader")

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "cpp", "c_sharp", "bash", "cmake", "css", "cuda", "dockerfile", "glsl", "hlsl", "html", "jai",
        "java", "javascript", "json", "lua", "make", "markdown", "python", "templ", "tsx", "vim", "yaml"
    },
    highlight = { enable = true, },
    indent = { enable = true },
    playground = { enable = true, },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<leader>al"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>ah"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["<leader>l"] = "@parameter.inner",
            },
            goto_next_end = {},
            goto_previous_start = {
                ["<leader>h"] = "@parameter.inner",
            },
            goto_previous_end = {},
        },
        select = {
            enable = true,
            lookahead = true,
      
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["ia"] = "@parameter.inner",
              ["aa"] = "@parameter.outer",
            },
            selection_modes = {
              ['@parameter.inner'] = 'v',
              ['@parameter.outer'] = 'v',
            },
            include_surrounding_whitespace = true,
          },
    },
})

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

require("treesitter-context").setup({
    line_numbers = true,
    mode = "topline",  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- separator = "-",
})

-- =================================================================================

require("neo-tree").setup({
    filesystem = { filtered_items = { always_show = { ".gitignore", ".ark_ignore", ".ignore", "wiki" } } }
})

-- =================================================================================

require("automaton").setup({})
-- =================================================================================

require('plenary.filetype').add_file('jai')
require('plenary.filetype').add_file('hlsl')
require('plenary.filetype').add_file('shader')
local actions = require('telescope.actions')
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.cycle_history_next,
                ['<C-k>'] = actions.cycle_history_prev
            }
        }
    }
})

-- =================================================================================
local conform_util = require("conform.util")
require("conform").setup({ 
    formatters_by_ft = { 
        -- c     = { "clang-format" },
        -- cpp   = { "clang-format" },
        -- h     = { "clang-format" },
        -- hpp   = { "clang-format" },
        -- cc    = { "clang-format" }, 
        cs     = { "csharpier" },
        jai    = { "jai-format" },
        shader = { "injected" },
    },
    formatters = {
        ["jai-format"] = {
            command = "jai-format",
            -- args = { "-silent", "-to_file", "$FILENAME" },
            args = { "-silent", "-to_stdout", "-from_stdin", "$RELATIVE_FILEPATH" },
            cwd = conform_util.root_file({ ".jai-format" }),
            stdin = true,
        },
        injected = {
            options = {
                -- Conform creates temporary filenames for injected regions.
                -- Some formatters use the extension to determine the language.
                lang_to_ext = {
                    jai = "jai",
                    hlsl = "hlsl",
                },

                -- Tree-sitter language name -> Conform formatter names.
                lang_to_formatters = {
                    jai = { "jai-format" },

                    -- Replace this with the Conform name of your HLSL formatter.
                    -- hlsl = { "clang_format" },
                }
            }
        }
    }
})

require("nvim_comment").setup({ comment_empty = false })
require("gitsigns").setup()
require("lualine").setup({ options = { theme = "material" }})
require("todo-comments").setup({
    keywords = {
        PERF = { alt = { "PERFORMANCE", "OPTIMIZE", "MEMORY" } },
        CLEANUP = { alt = { "NOCOMMIT", "nocommit" }, icon = "󰃢 ", color = pallete.love },
    },
})
require("neovim-project").setup({
    projects = {
        os.getenv("GAMEDEV_PATH") .. "/Projects/*",
        os.getenv("SECONDARY_GAMEDEV_PATH") .. "/Jai_Projects/*",
    },
})
-- =================================================================================

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local live_grep_jai_modules = function()
    local opts = {
        cwd = os.getenv("GAMEDEV_PATH") .. "/Tools/jai/",
        search_dirs = { "modules/", "how_to/" },
    }
    telescope_builtin.live_grep(opts)
end

local find_files_jai_modules = function()
    local opts = require('telescope.themes').get_dropdown({previewer = false})
    opts.cwd = os.getenv("GAMEDEV_PATH") .. "/Tools/jai/"
    opts.search_dirs = { "modules/", "how_to/" }
    telescope_builtin.find_files(opts)
end

vim.keymap.set("n", "<leader>jt", live_grep_jai_modules, { desc = "Live grep in jai modules" })
vim.keymap.set("n", "<leader>jf", find_files_jai_modules, { desc = "Fuzzy find files in jai modules" })