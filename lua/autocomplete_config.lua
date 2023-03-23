-- Setup nvim-cmp.
local cmp = require'cmp'

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
    entries = {name = 'wildmenu', separator = '|' }       
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping(function ()
                              close_completion_window(false)
                             end),
    ['<Up>'] = cmp.mapping(function ()
                              close_completion_window(true)
                           end),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }, 
  sources = cmp.config.sources({
    { name = 'treesitter' }, 
    -- { 
    --   name = 'buffer', 
    --   option = 
    --   {
    --     get_bufnrs = function()
    --       return vim.api.nvim_list_bufs()
    --     end
    --   }
    -- }
  }),
  -- sources = cmp.config.sources( {
  --   { name = 'nvim_lsp',
  --     entry_filter = function(entry)
  --                      return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
  --                    end },
  --   --{ name = 'vsnip' }, -- For vsnip users.
  -- }, {
  --   { name = 'buffer' },
  -- }),
  experimental = {
    ghost_text = true
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- require('lspconfig').clangd.setup {
--   cmd = {'clangd', '--header-insertion=never'},
--     capabilities = capabilities,
-- }
