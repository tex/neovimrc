require 'triptych'.setup {
  mappings = {
    -- Everything below is buffer-local, meaning it will only apply to Triptych windows
    show_help = 'g?',
    jump_to_cwd = '.',  -- Pressing again will toggle back
    nav_left = { 'h', '<Left>' },
    nav_right = { 'l', '<Right>', '<CR>' }, -- If target is a file, opens the file in-place
    open_hsplit = { '<C-s>' },
    open_vsplit = { '<C-v>' },
    open_tab = { '<C-t>' },
    cd = '<leader>cd',
    delete = 'd',
    add = 'a',
    copy = 'c',
    rename = 'r',
    cut = 'x',
    paste = 'p',
    quit = { '<Esc>', 'q', '-' },
    toggle_hidden = 'g.',
  },
  extension_mappings = {
        ['<space>gg'] = {
          mode = 'n',
          fn = function(target)
            require 'telescope.builtin'.live_grep {
              search_dirs = { vim.fn.input("Find files Root > ", target.dirname) }
            }
          end
        }
  },
  options = {
    dirs_first = true,
    show_hidden = false,
    line_numbers = {
      enabled = false,
      relative = false,
    },
    file_icons = {
      enabled = false,
      directory_icon = '',
      fallback_file_icon = ''
    },
    column_widths = { .25, .25, .5 }, -- Must add up to 1 after rounding to 2 decimal places
    highlights = { -- Highlight groups to use. See `:highlight` or `:h highlight`
      file_names = 'NONE',
      directory_names = 'NONE',
    },
    syntax_highlighting = { -- Applies to file previews
      enabled = true,
      debounce_ms = 100,
    },
    backdrop = 30 -- Backdrop opacity. 0 is fully opaque, 100 is fully transparent (disables the feature)
  },
  git_signs = {
    enabled = false,
    signs = {
      -- The value can be either a string or a table.
      -- If a string, will be basic text. If a table, will be passed as the {dict} argument to vim.fn.sign_define
      -- If you want to add color, you can specify a highlight group in the table.
      add = '+',
      modify = '~',
      rename = 'r',
      untracked = '?',
    },
  },
  diagnostic_signs = {
    enabled = false,
  }
}
