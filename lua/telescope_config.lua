-- require("telescope").load_extension("workspaces")

require("telescope").setup({
    extensions = {
      workspaces = {
        -- keep insert mode after selection in the picker, default is false
        keep_insert = false,
      }
    }
  })

