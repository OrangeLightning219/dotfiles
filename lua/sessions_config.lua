require("sessions").setup({
    -- autocmd events which trigger a session save
    --
    -- the default is to only save session files before exiting nvim.
    -- you may wish to also save more frequently by adding "BufEnter" or any
    -- other autocmd event
    events = { "VimLeavePre", "BufEnter" },

    -- default session filepath
    --
    -- if a path is provided here, then the path argument for commands and API
    -- functions will use session_filepath as a default if no path is provided.
    session_filepath = "",

    -- treat the default session filepath as an absolute path
    -- if true, all session files will be stored in a single directory
    absolute = false,
})

require("workspaces").setup({
    -- path to a file to store workspaces data in
    -- on a unix system this would be ~/.local/share/nvim/workspaces
    path = vim.fn.stdpath("data") .. "/workspaces",

    -- to change directory for nvim (:cd), or only for window (:lcd)
    -- deprecated, use cd_type instead
    -- global_cd = true,

    -- controls how the directory is changed. valid options are "global", "local", and "tab"
    --   "global" changes directory for the neovim process. same as the :cd command
    --   "local" changes directory for the current window. same as the :lcd command
    --   "tab" changes directory for the current tab. same as the :tcd command
    --
    -- if set, overrides the value of global_cd
    cd_type = "global",

    -- sort the list of workspaces by name after loading from the workspaces path.
    sort = true,

    -- sort by recent use rather than by name. requires sort to be true
    mru_sort = true,

    -- enable info-level notifications after adding or removing a workspace
    notify_info = true,

    -- lists of hooks to run after specific actions
    -- hooks can be a lua function or a vim command (string)
    -- lua hooks take a name, a path, and an optional state table
    -- if only one hook is needed, the list may be omitted
    hooks = {
        open = function()
          require("sessions").load(".nvim-session", { silent = true })
        end,
    },
})