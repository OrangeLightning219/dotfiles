require("nvim-tree").setup {
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = true,
      ignore_buffer_on_setup = false,

      view = {
        adaptive_size = false,
        centralize_selection = false,
        width = "17%",
        height = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          custom_only = false,
          list = {
            -- user mappings go here
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = false,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "★",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "",
              deleted = "✗",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      ignore_ft_on_setup = {},
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
      },
      filesystem_watchers = {
        enable = false,
        interval = 100,
        debounce_delay = 50,
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      log = {
        enable = false,
        truncate = true,
        types = {
          all = true,
          -- config = false,
          -- copy_paste = false,
          -- diagnostics = false,
          -- git = false,
          -- profile = false,
          -- watcher = false,
        },
      },
    }

vim.api.nvim_command[[
  autocmd ColorScheme * highlight! link NvimTreeGitNew TSString
  autocmd ColorScheme * highlight! link NvimTreeFileNew TSVariable

  autocmd ColorScheme * highlight! link NvimTreeFileDirty TSVariable
  autocmd ColorScheme * highlight! link NvimTreeGitDirty TSParameter
 
  autocmd ColorScheme * highlight! link NvimTreeFileStaged TSVariable
  autocmd ColorScheme * highlight! link NvimTreeGitStaged TSInclude
  
  autocmd ColorScheme * highlight! link NvimTreeFileRenamed TSVariable
  autocmd ColorScheme * highlight! link NvimTreeGitRenamed TSConstructor
  
  autocmd ColorScheme * highlight! link NvimTreeFileDeleted TSVariable
  autocmd ColorScheme * highlight! link NvimTreeGitDeleted TSFuncBuiltin
  
  autocmd ColorScheme * highlight! link NvimTreeFileIgnored TSVariable
  autocmd ColorScheme * highlight! link NvimTreeGitIgnored TSComment
]]
