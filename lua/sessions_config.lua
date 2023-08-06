require("auto-session").setup({
    -- log_level = 'debug',
    auto_save_enabled = true,
    session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
    },
    -- post_restore_cmds = {"EvenSplits"}
})

require("telescope").load_extension("session-lens")
