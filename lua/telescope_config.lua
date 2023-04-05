require('telescope').load_extension("workspaces")

require('telescope').setup({
    extensions = {
      workspaces = {
        -- keep insert mode after selection in the picker, default is false
        keep_insert = false,
      }
    }
  })

-- local actions = require("telescope.actions")
-- local action_state = require("telescope.actions.state")

-- local function find_files_custom()
--     local function run_selection(prompt_bufnr, map)
--         actions.select_default:replace(function()
--             actions.close(prompt_bufnr)
--             local selection = action_state.get_selected_entry().value
--             local current_file = vim.api.nvim_buf_get_name(0)

--             local selection_is_header = vim.endswith(selection, '.h')
--             local current_is_header = vim.endswith(current_file, '.h')
            
--             local splits = vim.api.nvim_tabpage_list_wins(0)
--             local splits_count = #splits
--             -- print(vim.inspect(vim.api.nvim_tabpage_list_wins(0)))
--             local current_split = vim.api.nvim_tabpage_get_win(0)
--             local other_split = 0

--             for i=1,splits_count do
--                 if splits[i] ~= current_split then
--                     other_split = splits[i]
--                     break
--                 end
--             end
--             -- print(current_split)

--             if splits_count == 1 then
--                 if not selection_is_header then
--                     vim.cmd(":topleft vsplit")
--                 else
--                     vim.cmd(":vsplit")
--                 end
--             elseif splits_count > 1 then
--                 if selection_is_header then
--                     if current_is_header then
--                         vim.api.nvim_win_hide(current_split)
--                     else
--                         vim.api.nvim_win_hide(other_split)
--                     end
--                     vim.cmd(":vsplit")
--                 else
--                     if current_is_header then
--                         vim.api.nvim_win_hide(other_split)
--                     else
--                         vim.api.nvim_win_hide(current_split)
--                     end
--                     vim.cmd(":topleft vsplit")

--                 end
--             end
--             vim.cmd(":edit " .. selection)
--         end)
--         return true
--     end

--     local opts = require('telescope.themes').get_dropdown({previewer = false})
--     opts["attach_mappings"] = run_selection

--     require('telescope.builtin').find_files(opts)
-- end

-- vim.api.nvim_create_user_command('FindFilesCustom', find_files_custom, {nargs = 0, desc = ''}) 