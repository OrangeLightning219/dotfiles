vim.cmd([[
    syntax on
]])

vim.g.mapleader = " "

vim.g.nobackup = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_transparency = 1
vim.g.neovide_normal_opacity = 1
vim.g.delimitMate_expand_cr = 1

vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.laststatus = 2
vim.opt.autoread = true
vim.opt.foldlevelstart = 99
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.background = "dark"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.linebreak = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.pumheight = 10
vim.opt.concealcursor = ""

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,resize"

vim.opt.guifont = { "FiraCode Nerd Font", ":h14" }
-- vim.opt.guifont = { "CaskaydiaCove NF", ":h12" }
-- vim.opt.guifont = { "JetBrainsMono NF", ":h12" }

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

keymap("n", "<C-u>",      "<C-u>zz", options)
keymap("i", "<C-u>",      "<C-u>zz", options)
keymap("n", "<C-d>",      "<C-d>zz", options)
keymap("i", "<C-d>",      "<C-d>zz", options)
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
keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", options)
keymap("n", "<leader>gr", ":Telescope lsp_references<CR>", options)
keymap("n", "<leader>gd", ":Telescope lsp_definitions<CR>", options)
keymap("n", "<leader>f",  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))<CR>", options)
keymap("n", "<leader>t",  ":Telescope live_grep<CR>", options)
keymap("n", "<leader>d",  ":Telescope diagnostics<CR>", options)
-- keymap("n", "<leader>e",  "<cmd>lua vim.diagnostic.open_float()<CR>", options)
keymap("n", "<leader>e",  ":Lspsaga diagnostic_jump_next<CR>", options)
keymap("n", "<leader>w",  ":Telescope neovim-project history<CR>", options)
keymap("n", "<leader>a",  ":EvenSplits<CR>", options)
keymap("n", "<leader>gg", ":LazyGitCurrentFile<CR>", options)

keymap("n", "<F5>", ":wa<CR>:Automaton tasks default<CR>", options)
keymap("i", "<F5>", "<Cmd>:wa<CR><Cmd>:Automaton tasks default<CR>", options)
keymap("n", "<F8>", ":wa<CR>:Automaton launch default<CR>", options)
keymap("i", "<F8>", "<Cmd>:wa<CR><Cmd>:Automaton launch default<CR>", options)

keymap("n", "<M-/>", ":CommentToggle<CR>", options)
keymap("i", "<M-/>", "<Cmd>:CommentToggle<CR>", options)
keymap("v", "<M-/>", ":CommentToggle<CR>", options)

keymap("n", "<C-s>", ":wa!<CR>", options)
keymap("i", "<C-s>", "<Cmd>:wa!<CR>", options)

keymap("n", "<M-.>",     ":try <bar> cn <bar> catch <bar> cfirst <bar> endtry<CR>", options)
keymap("i", "<M-.>",     "<Cmd>:try <bar> cn <bar> catch <bar> cfirst <bar> endtry<CR>", options)
keymap("n", "<M-,>",     ":try <bar> cp <bar> catch <bar> clast <bar> endtry<CR>", options)
keymap("i", "<M-,>",     ":try <bar> cp <bar> catch <bar> clast <bar> endtry<CR>", options)
keymap("n", "<leader>q", ":q<CR>", options)
keymap("n", "<leader>cq", ":cclose<CR>", options)

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

vim.opt.errorformat:append("%f:%l\\,%c:\\ Error:\\ %m")
vim.opt.errorformat:append("%f:%l\\,%c:\\ Warning:\\ %m")
vim.opt.errorformat:append("%f\\(%l\\,%c-%*[0-9]\\):\\ error\\ X%*[0-9]:\\ %m")

local function format(args)
    require("conform").format({ bufnr = args.buf })
end

local function highlight_yank(args)
    vim.highlight.on_yank({timeout = 350})
end

commands = {
    {events = {"User"}, patterns = {"SessionSavePre"}, command = "cclose"},
    {events = {"BufWritePost"}, patterns = {"*.jai"}, command = "JaiFormat"},
    {events = {"BufWritePre"}, patterns = {"*"}, callback = format},
    {events = {"BufNewFile", "BufReadPre"}, patterns = {"*.go", "*.templ"}, command = "setlocal noet ts=4 sw=4 sts=4"},
    {events = {"BufNewFile", "BufReadPre"}, patterns = {"*.templ"}, command = "setlocal nowrap"},
    {events = {"BufEnter", "BufFilePost"}, patterns = {"*.jai", "*.c", "*.cc", "*.cpp", "*.h", "*.hpp", "*.hlsl"}, command = "set commentstring=//\\ %s"},
    {events = {"BufEnter", "BufFilePost"}, patterns = {"*.py", "*.keymap"}, command = "set commentstring=#\\ %s"},
    -- {events = {"BufEnter", "BufFilePost"}, patterns = {"*.pixel", "*.vertex", "*.compute"}, command = "set filetype=hlsl"},
    {events = {"FileType"}, patterns = {"qf"}, command = "wincmd J"},
    {events = {"TextYankPost"}, patterns = {"*"}, callback = highlight_yank},
}

local autocommand_group = vim.api.nvim_create_augroup('auto_commands', {})

for _, c in ipairs(commands) do
    if c.callback == nil then
        vim.api.nvim_create_autocmd(c.events, {
            command = c.command,
            group = autocommand_group,
            pattern = c.patterns
        })
    else
        vim.api.nvim_create_autocmd(c.events, {
            callback = c.callback,
            group = autocommand_group,
            pattern = c.patterns
        })
    end
end

vim.filetype.add({
    extension = {
        jai = "jai",
        hlsl = "hlsl",
        shader = "hlsl",
        pixel = "hlsl",
        vertex = "hlsl",
        compute = "hlsl"
    }
})