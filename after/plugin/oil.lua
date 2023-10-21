require('oil').setup {
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    "icon",
    -- "permissions",
    "size",
    "mtime",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "n",
  },
  -- Restore window options to previous values when leaving an oil buffer
  restore_win_options = true,
  -- Skip the confirmation popup for simple operations
  skip_confirm_for_simple_edits = false,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "action.<name>",
  -- it will use the mapping at require("oil.action").<name>
  -- Set to `false` to remove a keymap
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-x>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-p>"] = "actions.preview",
    ["-"] = "actions.close",
    ["<M-->"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["<BS>"] = "actions.parent",
    ["gc"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["g."] = "actions.toggle_hidden",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = false,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 10,
    },
  },
}

vim.keymap.set('n', '<M-->', function() require('oil').open() end)

