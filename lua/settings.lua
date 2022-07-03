vim.cmd([[
    syntax on
    colorscheme rose-pine
]])

vim.g.mapleader = " "

vim.g.nobackup = true
vim.g.noswapfile = true
vim.g.neovide_remember_window_size = 'v:true'
vim.g.tabstob = 4
vim.g.nowrap = true
vim.g.nolist = true

vim.opt.laststatus = 2
vim.opt.autoread = true
vim.opt.foldlevelstart = 99
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.scrolloff = 4
vim.opt.termguicolors = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.background = 'dark'
vim.opt.mouse = 'a'
vim.opt.clipboard:append('unnamedplus')
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.linebreak = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'

vim.opt.guifont = { 'CaskaydiaCove NF', 'h14' }

local keymap = vim.api.nvim_set_keymap
local options = { noremap = true }

keymap( 'n', '<leader>sv', ':source $XDG_CONFIG_HOME/nvim/init.lua<CR>', options)
keymap( 'n', '<leader>r',  '@:', options)
keymap( 'n', '<Tab>',      ':bn<CR>', options)
keymap( 'n', '<S-Tab>',    ':bp<CR>', options)
keymap( 'n', '<C-h>',      '<C-w>h', options)
keymap( 'n', '<C-l>',      '<C-w>l', options)
keymap( 'n', '<C-j>',      '<C-w>j', options)
keymap( 'n', '<C-k>',      '<C-w>k', options)

options.silent = true

keymap( 'n', '<F8>', ':SymbolsOutline<CR>', options)
keymap( 'i', '<F8>', ':SymbolsOutline<CR>', options)

keymap( 'n', '<C-n>', ':NvimTreeToggle<CR>', options)

keymap( 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
keymap( 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
keymap( 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
keymap( 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)

keymap( 'n', 'K',          ':Lspsaga hover_doc<CR>', options)
keymap( 'i', '<C-k>',      '<Cmd>Lspsaga signature_help<CR>', options)
keymap( 'n', 'gh',         '<Cmd>Lspsaga lsp_finder<CR>', options)
keymap( 'n', '<leader>ca', '<cmd>lua require(\'lspsaga.codeaction\').code_action()<CR>', options)
keymap( 'v', '<leader>ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<CR>', options)

keymap( 'n', '<M-/>', ':CommentToggle<CR>', options)
keymap( 'i', '<M-/>', '<Cmd>:CommentToggle<CR>', options)
keymap( 'v', '<M-/>', ':CommentToggle<CR>', options)

keymap( 'n', '<C-s>', ':w<CR>', options)
keymap( 'i', '<C-s>', '<Cmd>:w<CR>', options)

vim.cmd([[
    augroup AUTOCMD_GROUP
        autocmd!
        autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 100)
        autocmd BufWritePre *.h lua vim.lsp.buf.formatting_sync(nil, 100)
        autocmd BufWritePre *.cpp lua vim.lsp.buf.formatting_sync(nil, 100)
        autocmd BufWritePre *.hpp lua vim.lsp.buf.formatting_sync(nil, 100)
        autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
        autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync(nil, 100)
        autocmd BufEnter *.c,*.cpp,*.h,*.hpp,*.hlsl :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
        autocmd BufFilePost *.c,*.cpp,*.h,*.hpp,*.hlsl :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    augroup END
]])