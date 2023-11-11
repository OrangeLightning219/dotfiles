vim.cmd([[
    syntax on
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
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.background = "dark"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.linebreak = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.pumheight = 10

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,resize"

if vim.fn.has("macunix") ~= 0 then
    vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h12" }
else
vim.opt.guifont = { "FiraCode Nerd Font", ":h14" }
-- vim.opt.guifont = { "CaskaydiaCove NF", ":h12" }
-- vim.opt.guifont = { "JetBrainsMono NF", ":h12" }
end

local keymap = vim.api.nvim_set_keymap
local options = { noremap = true }

keymap("n", "<Up>", "", options)
keymap("i", "<Up>", "", options)
keymap("n", "<Down>", "", options)
keymap("i", "<Down>", "", options)
keymap("n", "<Right>", "", options)
keymap("i", "<Right>", "", options)
keymap("n", "<Left>", "", options)
keymap("i", "<Left>", "", options)

keymap("n", "<leader>r",  "@:", options)
keymap("n", "<C-h>",      "<C-w>h", options)
keymap("n", "<C-l>",      "<C-w>l", options)
keymap("n", "<C-j>",      "<C-w>j", options)
keymap("n", "<C-k>",      "<C-w>k", options)
keymap("n", "<leader>s",  "<C-w>x", options)

options.silent = true

keymap("n", "<leader>1", ":Neotree toggle<CR>", options)

keymap("n", "<leader>n",  "<cmd>lua vim.lsp.buf.rename()<CR>", options)
keymap("n", "<C-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
keymap("i", "<C-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)
keymap("n", "<leader>gr", ":Telescope lsp_references<CR>", options)
keymap("n", "<leader>gd", ":Telescope lsp_definitions<CR>", options)
keymap("n", "<leader>f",  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))<CR>", options)
keymap("n", "<leader>t",  ":Telescope live_grep<CR>", options)
keymap("n", "<leader>d",  ":Telescope lsp_dynamic_workspace_symbols<CR>", options)
keymap("n", "<leader>e",  ":Telescope diagnostics<CR>", options)
keymap("n", "<leader>w",  ":Telescope neovim-project history<CR>", options)
keymap("n", "<leader>a",  ":EvenSplits<CR>", options)
keymap("n", "<leader>gg", ":LazyGit<CR>", options)

function run_build_task()
    vim.cmd("wa")
    require("yabs"):run_task("build")
end
vim.api.nvim_create_user_command("RunBuildTask", run_build_task, {nargs = 0, desc = ""})

keymap("n", "<F5>", ":RunBuildTask<CR>", options)
keymap("i", "<F5>", "<cmd>:RunBuildTask<CR>", options)

keymap("n", "<M-/>", ":CommentToggle<CR>", options)
keymap("i", "<M-/>", "<Cmd>:CommentToggle<CR>", options)
keymap("v", "<M-/>", ":CommentToggle<CR>", options)

keymap("n", "<C-s>", ":wa!<CR>", options)
keymap("i", "<C-s>", "<Cmd>:wa!<CR>", options)

keymap("n", "<M-.>",     ":try <bar> cn <bar> catch <bar> cfirst <bar> endtry<CR>", options)
keymap("i", "<M-.>",     "<Cmd>:try <bar> cn <bar> catch <bar> cfirst <bar> endtry<CR>", options)
keymap("n", "<M-,>",     ":try <bar> cp <bar> catch <bar> clast <bar> endtry<CR>", options)
keymap("i", "<M-,>",     ":try <bar> cp <bar> catch <bar> clast <bar> endtry<CR>", options)
keymap("n", "<leader>q", ":cclose<CR>", options)

local function jai_format()
    local job = require("plenary.job")
    local current_file = vim.fn.expand("%:p")
    job:new({
        command = "jai-format",
        args = { current_file },
        cwd = vim.fn.getcwd(),
        on_exit = function(j, return_val)
            local callback = vim.schedule_wrap(function(file) 
                vim.api.nvim_command("checktime " .. file)
            end)
            callback(current_file)
        end,
    }):start()
end

vim.api.nvim_create_user_command("JaiFormat", jai_format, {nargs = 0, desc = ""}) 

local function even_splits()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", true, false, true), "n", false)
end

vim.api.nvim_create_user_command("EvenSplits", even_splits, {nargs = 0, desc = ""}) 

vim.cmd([[
    augroup AUTOCMD_GROUP
        autocmd!
        autocmd BufEnter *.jai set errorformat=%f:%l\\,%c:\ Error:\ %m
        autocmd BufWritePost *.jai JaiFormat
        autocmd BufWritePre *.c,*.h,*.cpp,*.hpp ClangFormat
        autocmd BufEnter,BufFilePost *.jai,*.c,*.cpp,*.h,*.hpp,*.hlsl :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
        autocmd BufEnter,BufFilePost *.py :lua vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
    augroup END
]])

vim.filetype.add({
    extension = {
        jai = "jai"
    }
})