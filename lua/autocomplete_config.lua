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
  -- view = {                                                
  --   entries = {name = 'wildmenu', separator = '|' }       
  -- },
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
  sources = cmp.config.sources({{ name = 'treesitter'}, { name = 'buffer', option = {
                                                                              get_bufnrs = function()
                                                                                return vim.api.nvim_list_bufs()
                                                                              end
                                                                            }}}),
  -- sources = cmp.config.sources({{ name = 'treesitter' }},
  --                              {{ name = 'buffer', option = {
  --                                   get_bufnrs = function()
  --                                     return vim.api.nvim_list_bufs()
  --                                   end
  --                                 } }}),
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



-- local cpp_cmp = {}

-- local registered = false
-- cpp_cmp.setup = function()
--   if registered then
--     return
--   end

--   registered = true

--   local source = {}

--   source.new = function()
--     return setmetatable({}, {__index = source})
--   end

--   -- source.get_trigger_characters = function()
--   --   return {'.', '>', ':'}
--   -- end

--   source.get_keyword_pattern = function(self, params)
--     -- return [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\%(\w\|á\|Á\|é\|É\|í\|Í\|ó\|Ó\|ú\|Ú\)*\%(-\%(\w\|á\|Á\|é\|É\|í\|Í\|ó\|Ó\|ú\|Ú\)*\)*\)]]
--     return [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-]\w*\)*\)]]
--   end


--   source.complete = function(self, request, callback)

--     local input = string.sub(request.context.cursor_before_line, 1, request.offset)

--     if request.completion_context.triggerCharacter ~= nil then

--       print("Trigger completion request")
--       -- print(vim.inspect(request))
--       local trigger = request.completion_context.triggerCharacter
--     else
--       print("Completion request")
--       -- print(vim.inspect(request))
--     end
--     print("Input: " .. input)

--     local items = {}

--     local completion_items = {'test1', 'test2', 'test3'}

--     for index, item in ipairs(completion_items) do
--       print("Adding "..item)
--       table.insert(items, {
--         filterText = 'Local Variable',
--         label = item,
--         -- textEdit = {
--         --   newText = item,
--         --   range = {
--         --     start = {
--         --       line = request.context.cursor.row - 1,
--         --       character = request.context.cursor.col - 1 - #input,
--         --     },
--         --     ['end'] = {
--         --       line = request.context.cursor.row - 1,
--         --       character = request.context.cursor.col - 1,
--         --     }
--         --   }
--         -- }
--       })
--     end

--     callback({items = items, isIncomplete = false})

--   end

--   cmp.register_source('nvim_cpp', source.new())

--   cmp.setup.filetype({'cpp', 'c', 'h', 'hpp'}, {sources = cmp.config.sources({{name = 'nvim_cpp'}})})
--   --, {name = 'buffer'}

-- end

-- cpp_cmp.setup()

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- require('lspconfig').clangd.setup {
--   cmd = {'clangd', '--header-insertion=never'},
--     capabilities = capabilities,
-- }
