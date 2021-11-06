nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap <silent>K :Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

nnoremap <silent> <M-/> :CommentToggle<CR>
vnoremap <silent> <M-/> :CommentToggle<CR>

nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <Cmd>:w<CR>

augroup AUTOCMD_GROUP
    autocmd!
    autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.h lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.cpp lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.hpp lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.fs lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufEnter *.c,*.cpp,*.h,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    autocmd BufFilePost *.c,*.cpp,*.h,*.hpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
augroup END
