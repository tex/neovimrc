local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.python_file_finder_pipeline({
      -- file_command = {'find', '.', '-type', 'f', '-printf', '%P\n'}, 
      file_command = {'fd', '-tf' }, 
      -- dir_command = {'find', '.', '-type', 'd', '-printf', '%P\n'},
      dir_command = {'fd', '-td' },
      -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
      -- found at https://github.com/nixprime/cpsm
      filters = {'fuzzy_filter', 'difflib_sorter'},
      debounce = 250,
    }),
    -- wilder.substitute_pipeline(),
    wilder.cmdline_pipeline({
      -- sets the language to use, 'vim' and 'python' are supported
      language = 'python',
      -- 0 turns off fuzzy matching
      -- 1 turns on fuzzy matching
      -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
      fuzzy = 2,
      hide_in_substitute = 1,
    }),
    wilder.python_search_pipeline({
      -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
      pattern = wilder.python_fuzzy_pattern(),
      -- omit to get results in the order they appear in the buffer
      sorter = wilder.python_difflib_sorter(),
      -- can be set to 're2' for performance, requires pyre2 to be installed
      -- see :h wilder#python_search() for more details
      engine = 're',
    })
  ),
})

local gradient = {
  '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
  '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
  '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
  '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
}

for i, fg in ipairs(gradient) do
  gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', {{a = 1}, {a = 1}, {foreground = fg}})
end

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
      -- 'single', 'double', 'rounded' or 'solid'
      -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
      border = 'rounded',
      max_height = '75%',      -- max height of the palette
      min_height = 0,          -- set to the same as 'max_height' for a fixed height window
      prompt_position = 'bottom', -- 'top' or 'bottom' to set the location of the prompt
      reverse = 1,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'

      highlights = {
        gradient = gradient, -- must be set
        -- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
      },
      highlighter = wilder.highlighter_with_gradient({
        wilder.basic_highlighter(), -- wilder.lua_fzy_highlighter() doesn't work with gradient
      }),
      left = {' ', wilder.popupmenu_devicons()},
      right = {' ', wilder.popupmenu_scrollbar()},
    }),
    wilder.popupmenu_border_theme({
      highlights = {
        border = 'Normal', -- highlight to use for the border
      },
      -- 'single', 'double', 'rounded' or 'solid'
      -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
      border = 'rounded',
    })
  ),
  ['/'] = wilder.wildmenu_renderer({
    highlights = {
      gradient = gradient,
    },
    highlighter = wilder.highlighter_with_gradient({wilder.basic_highlighter()})
  }),
  ['?'] = wilder.wildmenu_renderer({
    highlights = {
      gradient = gradient,
    },
    highlighter = wilder.highlighter_with_gradient({wilder.basic_highlighter()})
  }),
  substitute = wilder.wildmenu_renderer({dummy = 'dict'}),
}))
