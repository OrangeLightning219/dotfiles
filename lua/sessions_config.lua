local function handle_nvim_tree()
    nvim_tree = require("nvim-tree.api")
    for i, buffer in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buffer) and nvim_tree.tree.is_tree_buf(buffer) then
            nvim_tree.tree.open()
        end
    end
end

require("auto-session").setup({
    -- log_level = "debug",
    auto_save_enabled = true,
    session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
    },
    post_restore_cmds = {handle_nvim_tree}
})

require("telescope").load_extension("session-lens")
