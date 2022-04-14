syntax on

let mapleader = " "

set nowrap linebreak nolist
set splitbelow splitright
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set shiftwidth=4
set laststatus=2
set mouse=a
set autoread
set nobackup
set noswapfile
set nu
set foldlevelstart=99
set clipboard+=unnamedplus
set nohlsearch
set hidden
set noerrorbells
set ignorecase
set smartcase
set incsearch
set scrolloff=8
set signcolumn=yes
set termguicolors
set completeopt=menu,menuone,noselect
colorscheme rose-pine
set background=dark

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>r @:
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

nnoremap <F8> :SymbolsOutline<CR>
inoremap <F8> :SymbolsOutline<CR>