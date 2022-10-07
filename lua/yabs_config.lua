require('yabs'):setup({
  languages = { -- List of languages in vim's `filetype` format
    cpp = {
      default_task = 'build',
      tasks = {
        build = {
          command = 'build.bat',
          output = 'quickfix', -- Where to show output of the
          -- command. Can be `buffer`,
          -- `consolation`, `echo`,
          -- `quickfix`, `terminal`, or `none`
          opts = { -- Options for output (currently, there's only
            -- `open_on_run`, which defines the behavior
            -- for the quickfix list opening) (can be
            -- `never`, `always`, or `auto`, the default)
            open_on_run = 'auto',
          },
        },
      },
    },
  },
  tasks = { -- Same values as `language.tasks`, but global
  },
  opts = { -- Same values as `language.opts`
    output_types = {
      quickfix = {
        open_on_run = 'always',
      },
    },
  },
})