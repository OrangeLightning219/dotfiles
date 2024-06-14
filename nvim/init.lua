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
        ['@constant'] = {fg = 'iris', link = ""},
        ['@constructor'] = {fg = 'rose'},
        ['@keyword'] = {fg = pallete.pine, link = ""},
        ['@repeat'] = {fg = pallete.pine, link = ""},
        ['@conditional'] = {fg = pallete.pine, link = ""},
        ['@exception'] = {fg = pallete.pine, link = ""},
        ['@operator'] = {fg = pallete.pine, link = ""},
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

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- configs.jails = {
--     default_config = {
--         cmd = { "jails" },
--         filetypes = { "jai" },
--         root_dir = util.path.dirname,
--     },
-- }

-- vim.lsp.set_log_level("debug")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- require("lspconfig").clangd.setup({
--     cmd = {"clangd", "--header-insertion=never"},
--     capabilities = capabilities
-- })

-- require("lspconfig").pyright.setup({
--     capabilities = capabilities
-- })

if vim.fn.has("macunix") == 0 then
    -- require("lspconfig").jails.setup({
    --     capabilities = capabilities,
    --     root_dir = function(fname)
    --         return vim.fn.getcwd()
    --     end
    -- })
end

require("lspconfig").gopls.setup({})
require("lspconfig").htmx.setup({})

local function lsp_symbol(name, icon)
    vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, texthl = "Diagnostic" .. name })
end

lsp_symbol("Error", "")
lsp_symbol("Hint", "")
lsp_symbol("Info", "")
lsp_symbol("Warn", "")

-- =================================================================================

local cmp = require("cmp")

snippets_filter = function(entry)
    return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
end 

cmp.setup({
    view = { entries = { name = "custom", separator = "|" } },
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            vim_item.dup = 0
            return kind
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<CR>"] = cmp.mapping.confirm({ select = true })
    }, 
    sources = cmp.config.sources({
        { name = "nvim_lsp", entry_filter = snippets_filter }, 
        -- { name = 'nvim_lsp_signature_help' },
        { name = "buffer" }
    }),
    experimental = {
        ghost_text = true
    },
    snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
})

cmp.setup.cmdline("/", {sources = {{ name = "buffer" }}})
cmp.setup.cmdline(":", {sources = cmp.config.sources({{ name = "path" }}, {{ name = "cmdline" }})})

-- Autocomplete popup highlight groups
vim.api.nvim_set_hl(0, "PmenuSel", { bg = pallete.overlay, fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = pallete.text, bg = pallete.nc })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = pallete.subtle, bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = pallete.love, bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = pallete.love, bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = pallete.gold, bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = pallete.surface, bg = pallete.gold })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = pallete.surface, bg = pallete.gold })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = pallete.surface, bg = pallete.gold })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = pallete.surface, bg = pallete.subtle })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = pallete.surface, bg = pallete.foam })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = pallete.surface, bg = pallete.pine })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = pallete.surface, bg = pallete.iris })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = pallete.surface, bg = pallete.iris })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = pallete.surface, bg = pallete.iris })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = pallete.surface, bg = pallete.rose })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = pallete.surface, bg = pallete.foam })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = pallete.surface, bg = pallete.foam })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = pallete.surface, bg = pallete.foam })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = pallete.surface, bg = pallete.rose })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = pallete.surface, bg = pallete.gold })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = pallete.surface, bg = pallete.gold })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = pallete.surface, bg = pallete.rose })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = pallete.surface, bg = pallete.gold })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = pallete.surface, bg = pallete.gold })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = pallete.surface, bg = pallete.foam })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = pallete.surface, bg = pallete.foam })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = pallete.surface, bg = pallete.foam })

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

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "cpp", "bash", "cmake", "cuda", "dockerfile", "glsl", "hlsl", "html", "jai",
        "java", "javascript", "json", "lua", "make", "markdown", "python", "vim", "yaml"
    },
    highlight = { enable = true, },
    indent = { enable = true },
    playground = { enable = false, }
})

-- =================================================================================

require("neo-tree").setup({
    filesystem = { filtered_items = { always_show = { ".gitignore" } } }
})

-- =================================================================================

require("automaton").setup({})

-- =================================================================================

require('plenary.filetype').add_file('jai')
require('plenary.filetype').add_file('hlsl')
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
require("conform").setup({ 
    formatters_by_ft = { 
        html  = { "djlint" }, 
        go    = { "goimports", "gofmt" },
        templ = { "templ" },
        c     = { "clang-format" },
        cpp   = { "clang-format" },
        h     = { "clang-format" },
        hpp   = { "clang-format" },
        cc    = { "clang-format" }, 
    } 
})
require("conform").formatters.djlint = { prepend_args = { "--profile=golang", "--max-blank-lines=1", "--format-js", "--indent-js=4" } }

require("nvim_comment").setup({ comment_empty = false })
require("gitsigns").setup()
require("lualine").setup({ options = { theme = "material" }})
require("todo-comments").setup({
    keywords = {
        PERF = { alt = { "PERFORMANCE", "OPTIMIZE", "MEMORY" } },
    },
})
require("neovim-project").setup({
    projects = {
        os.getenv("GAMEDEV_PATH") .. "/Projects/*"
    },
})
-- =================================================================================
