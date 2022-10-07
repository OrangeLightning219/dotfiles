vim.cmd([[
    syntax on
    colorscheme rose-pine
]])

vim.g.mapleader = " "

vim.g.nobackup = true
vim.g.noswapfile = true
vim.g.neovide_remember_window_size = true
vim.g.tabstob = 4
vim.g.nowrap = true
vim.g.nolist = true
vim.g.delimitMate_expand_cr = 1

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

vim.opt.guifont = { 'CaskaydiaCove NF', ':h11' }

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

keymap( 'n', '<C-n>', ':NvimTreeToggle<CR>', options)

keymap( 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
keymap( 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
keymap( 'n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', options)

keymap( 'n', '<leader>gr', ':Telescope lsp_references<CR>', options)
keymap( 'n', '<leader>gd', ':Telescope lsp_definitions<CR>', options)

keymap('n', '<leader>f', "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))<CR>", options)
keymap('n', '<leader>t', ':Telescope live_grep<CR>', options)
keymap('n', '<leader>d', ':Telescope lsp_dynamic_workspace_symbols<CR>', options)
keymap('n', '<leader>e', ':Telescope diagnostics<CR>', options)

keymap( 'n', 'K',          ':Lspsaga hover_doc<CR>', options)
keymap( 'i', '<C-k>',      '<Cmd>Lspsaga signature_help<CR>', options)
keymap( 'n', 'gh',         '<Cmd>Lspsaga lsp_finder<CR>', options)
keymap( 'n', '<leader>ca', '<cmd>lua require(\'lspsaga.codeaction\').code_action()<CR>', options)
keymap( 'v', '<leader>ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<CR>', options)

keymap( 'n', '<M-/>', ':CommentToggle<CR>', options)
keymap( 'i', '<M-/>', '<Cmd>:CommentToggle<CR>', options)
keymap( 'v', '<M-/>', ':CommentToggle<CR>', options)

keymap( 'n', '<C-s>', ':wa<CR>', options)
keymap( 'i', '<C-s>', '<Cmd>:wa<CR>', options)


keymap( 'n', '<F5>', '<cmd>:wa <bar> lua require("yabs"):run_task("build")<CR>', options)
keymap( 'i', '<F5>', '<cmd>:wa <bar> lua require("yabs"):run_task("build")<CR>', options)
keymap('n', '<M-.>', ':cn<CR>', options)
keymap('i', '<M-.>', '<Cmd>:cn<CR>', options)
keymap('n', '<M-,>', ':cp<CR>', options)
keymap('i', '<M-,>', '<Cmd>:cp<CR>', options)
keymap( 'n', '<leader>q', ':cclose<CR>', options)


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
        autocmd BufEnter *.c,*.cpp,*.h,*.hpp set errorformat=\ %#%f(%l\\\,%c):\ error\ C%n:\ %m 
        autocmd BufFilePost *.c,*.cpp,*.h,*.hpp,*.hlsl :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    augroup END
]])
