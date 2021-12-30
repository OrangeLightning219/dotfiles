function! GetOS() abort
    if has('win64') || has('win32') || has('win16')
        return 'WINDOWS'
    else
       return toupper(substitute(system('uname'), '\n', '', ''))
    endif
endfunction

if (GetOS() =~# 'WINDOWS')
    source  %XDG_CONFIG_HOME%/nvim/plugins.vim

    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/autocomplete.lua
    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/lspsaga.lua
    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/nvim-tree.lua
    source  %XDG_CONFIG_HOME%/nvim/plugin-configs/nvim-tree.vim
    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/lualine.lua
    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/tree-sitter.lua
    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/neogit.lua
    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/nvim-comment.lua
    luafile %XDG_CONFIG_HOME%/nvim/plugin-configs/trouble.lua
    source  %XDG_CONFIG_HOME%/nvim/plugin-configs/templates.vim

    source %XDG_CONFIG_HOME%/nvim/settings.vim
    source %XDG_CONFIG_HOME%/nvim/neovide.vim
    source %XDG_CONFIG_HOME%/nvim/lsp.vim
else
    source  $XDG_CONFIG_HOME/nvim/plugins.vim

    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/autocomplete.lua
    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/lspsaga.lua
    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/nvim-tree.lua
    source  $XDG_CONFIG_HOME/nvim/plugin-configs/nvim-tree.vim
    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/lualine.lua
    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/tree-sitter.lua
    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/neogit.lua
    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/nvim-comment.lua
    luafile $XDG_CONFIG_HOME/nvim/plugin-configs/trouble.lua
    source  $XDG_CONFIG_HOME/nvim/plugin-configs/templates.vim

    source $XDG_CONFIG_HOME/nvim/settings.vim
    source $XDG_CONFIG_HOME/nvim/neovide.vim
    source $XDG_CONFIG_HOME/nvim/lsp.vim

endif