local jai_exe = "jai"
if vim.fn.has("macunix") then
    jai_exe = "jai-macos"
end

require("yabs"):setup({
  languages = {
    cpp = {
      default_task = "build",
      tasks = {
        build = {
          command = "build.bat",
          output = "quickfix",
          opts = {
            open_on_run = "auto",
          },
        },
      },
    },
    jai = {
      default_task = "build",
      tasks = {
        build = {
          command = jai_exe .. " ./first.jai",
          output = "quickfix", 
          opts = {
            open_on_run = "auto",
          },
        },
      }
    }
  },
  tasks = { -- Same values as `language.tasks`, but global
    build = {
      command = jai_exe .. " ./first.jai",
      output = "quickfix",
      opts = {
        open_on_run = "auto",
      },
    }
  },
  opts = { -- Same values as `language.opts`
    output_types = {
      quickfix = {
        open_on_run = "always",
      },
    },
  },
})
