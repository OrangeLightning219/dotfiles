require("settings")
require("plugins")

-- =================================================================================

require("rose-pine.config").options.dark_variant = "moon"
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

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

configs.jails = {
    default_config = {
        cmd = { "jails" },
        filetypes = { "jai" },
        root_dir = util.path.dirname,
    },
}

-- vim.lsp.set_log_level("debug")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").clangd.setup({
    cmd = {"clangd", "--header-insertion=never"},
    capabilities = capabilities
})

require("lspconfig").pyright.setup({
  capabilities = capabilities
})

if vim.fn.has("macunix") == 0 then
    require("lspconfig").jails.setup({
        capabilities = capabilities,
        root_dir = function(fname)
            return vim.fn.getcwd()
        end
    })
end

local function lsp_symbol(name, icon)
  vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, texthl = "Diagnostic" .. name })
end

lsp_symbol("Error", "")
lsp_symbol("Hint", "")
lsp_symbol("Info", "")
lsp_symbol("Warn", "")

-- =================================================================================

local cmp = require("cmp")

local function close_completion_window(moveUp)
  if cmp.visible() then
    cmp.close()
  end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line_count = vim.api.nvim_buf_line_count(0)

  if moveUp and row ~= 1 then
    row = row - 1
  elseif not moveUp and row ~= line_count then
    row = row + 1
  end
  vim.api.nvim_win_set_cursor(0, {row, col})
end

snippets_filter = function(entry)
  return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
end 

cmp.setup({
    view = { entries = {name = "custom", separator = "|" } },
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
        ["<Down>"] = cmp.mapping(function () close_completion_window(false) end),
        ["<Up>"] = cmp.mapping(function () close_completion_window(true) end),
    }, 
    sources = cmp.config.sources({
        { name = "nvim_lsp", entry_filter = snippets_filter, allow_duplicates = false, dup = 0 }, 
        -- { name = 'nvim_lsp_signature_help' },
        { name = "buffer", allow_duplicates = false, dup = 0 }
    }),
    experimental = {
        ghost_text = true
    }
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
        "c", "cpp", "bash", "cmake", "cuda", "dockerfile", "glsl", "html", "jai",
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

local tasks = {
  build = {
    command = "jai ./first.jai",
    output = "quickfix", 
    opts = { open_on_run = "auto" },
  },
}

require("yabs"):setup({
  languages = {
    jai = { default_task = "build", tasks = tasks }
  },
  tasks = tasks,
})

-- =================================================================================
require("telescope").setup()
require("nvim_comment").setup({ comment_empty = false })
require("gitsigns").setup()
require("lualine").setup({ options = { theme = "material" }})
require("todo-comments").setup({
    keywords = {
        PERF = { alt = { "PERFORMANCE", "OPTIMIZE", "MEMORY" } },
    },
})