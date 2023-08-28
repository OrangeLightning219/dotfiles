-- Setup nvim-cmp.
local cmp = require"cmp"

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

cmp.setup({
    view = {                                                
        entries = {name = "wildmenu", separator = "|" }       
    },
    snippet = {
    -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping(function ()
                                    close_completion_window(false)
                                end),
        ["<Up>"] = cmp.mapping(function ()
                                close_completion_window(true)
                               end),
    }, 
    sources = cmp.config.sources({
    { 
        name = "nvim_lsp",
        entry_filter = function(entry)
                           return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                       end 
    }, 
    { name = "buffer" }
    }),
    experimental = {
        ghost_text = true
    }
})

cmp.setup.cmdline("/", {sources = {{ name = "buffer" }}})

cmp.setup.cmdline(":", {sources = cmp.config.sources({{ name = "path" }}, {{ name = "cmdline" }})})

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

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").clangd.setup({
    cmd = {"clangd", "--header-insertion=never"},
    capabilities = capabilities,
})

require("lspconfig").pyright.setup({})

if not (vim.fn.has("macunix")) then
    require("lspconfig").jails.setup({
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
