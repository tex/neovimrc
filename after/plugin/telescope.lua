local actions = require("telescope.actions")
local action_state = require('telescope.actions.state')
local transform_mod = require("telescope.actions.mt").transform_mod

local bookmark_actions = require('telescope').extensions.vim_bookmarks.actions
require('telescope').extensions.vim_bookmarks.all {
    attach_mappings = function(_, map) 
        map('n', 'dd', bookmark_actions.delete_selected_or_at_cursor)
        return true
    end
}


local function multiopen(prompt_bufnr, method)
  local edit_file_cmd_map = {
    vertical = "vsplit",
    horizontal = "split",
    tab = "tabedit",
    default = "edit",
  }
  local edit_buf_cmd_map = {
    vertical = "vert sbuffer",
    horizontal = "sbuffer",
    tab = "tab sbuffer",
    default = "buffer",
  }
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()

  if #multi_selection > 1 then
      require("telescope.pickers").on_close_prompt(prompt_bufnr)
      pcall(vim.api.nvim_set_current_win, picker.original_win_id)

      for i, entry in ipairs(multi_selection) do
          local filename, row, col

          if entry.path or entry.filename then
              filename = entry.path or entry.filename

              row = entry.row or entry.lnum
              col = vim.F.if_nil(entry.col, 1)
          elseif not entry.bufnr then
              local value = entry.value
              if not value then
                  return
              end

              if type(value) == "table" then
                  value = entry.display
              end

              local sections = vim.split(value, ":")

              filename = sections[1]
              row = tonumber(sections[2])
              col = tonumber(sections[3])
          end

          local entry_bufnr = entry.bufnr

          if entry_bufnr then
              if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                  vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
              end
              local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
              pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
          else
              local command = i == 1 and "edit" or edit_file_cmd_map[method]
              if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                  filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                  pcall(vim.cmd, string.format("%s %s", command, filename))
              end
          end

          if row and col then
              pcall(vim.api.nvim_win_set_cursor, 0, { row, col - 1 })
          end
      end
  else
      actions["select_" .. method](prompt_bufnr)
  end
end

local custom_actions = transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
        multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
        multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open_tab = function(prompt_bufnr)
        multiopen(prompt_bufnr, "tab")
    end,
    multi_selection_open = function(prompt_bufnr)
        multiopen(prompt_bufnr, "default")
    end,
})

local function stopinsert(callback)
  return function(prompt_bufnr)
      -- vim.cmd.stopinsert()
      vim.cmd("stopinsert")
      vim.schedule(function()
          callback(prompt_bufnr)
      end)
  end
end

require'telescope'.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>']  = 'move_selection_next',
        ['<C-k>']  = 'move_selection_previous',
        ['<C-p>']  = 'cycle_history_prev',
        ['<C-n>']  = 'cycle_history_next',
        ['<C-b>']  = 'preview_scrolling_up',
        ['<C-f>']  = 'preview_scrolling_down',
        ['<C-q>']  = 'close',
        ['<M-a>']  = 'toggle_all',
        ['<M-q>']  = 'smart_send_to_qflist',
        ['<M-Q>']  = 'smart_add_to_qflist',
        ['<M-l>']  = 'smart_send_to_loclist',
        ['<M-L>']  = 'smart_add_to_loclist',
        ['<M-y>']  = 'open_qflist',
        ['<C-a>']  = function() feedkeys('<Home>') end,
        ['<C-e>']  = function() feedkeys('<End>') end,
        ['<M-BS>'] = function() vim.api.nvim_input('<C-w>') end,
        ['<C-u>']  = false,
        ['<C-v>']  = stopinsert(custom_actions.multi_selection_open_vertical),
        ['<C-s>']  = stopinsert(custom_actions.multi_selection_open_horizontal),
        ['<C-t>']  = stopinsert(custom_actions.multi_selection_open_tab),
        ['<CR>']   = stopinsert(custom_actions.multi_selection_open),
      },
      n = {
        ['<C-q>'] = 'close',
        ['<C-c>'] = 'close',
        ["<C-v>"] = custom_actions.multi_selection_open_vertical,
        ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
        ["<C-t>"] = custom_actions.multi_selection_open_tab,
        ["<CR>"] = custom_actions.multi_selection_open,
      }
    },
    layout_config = {
      width = 0.9,
      horizontal = {
        preview_width = 80
      }
    },
    selection_caret = '▶ ',
    multi_icon = '',
    path_display = { 'truncate' },
    prompt_prefix = '   ',
    no_ignore = true,
    file_ignore_patterns = {
      '%.git/', 'node_modules/', '%.npm/', '__pycache__/', '%[Cc]ache/',
      '%.dropbox/', '%.dropbox_trashed/', '%.local/share/Trash/', '%.py[c]',
      '%.sw.?', '~$', '%.tags', '%.gemtags', '%.csv$', '%.tsv$', '%.tmp',
      '%.plist$', '%.pdf$', '%.jpg$', '%.JPG$', '%.jpeg$', '%.png$',
      '%.class$', '%.pdb$', '%.dll$'
    }
  },
  pickers = {
    -- find_files = { mappings = telescope_multiselect_mappings },
    -- grep_string = { mappings = telescope_multiselect_mappings }
    quickfix             = picker_default_config,
    tagstack             = picker_default_config,
    jumplist             = picker_default_config,
    lsp_references       = picker_default_config,
    lsp_definitions      = picker_default_config,
    lsp_type_definitions = picker_default_config,
    lsp_implementations  = picker_default_config,
  },
  extensions = {
      cder = {
            dir_command = { 'fd', '--type=d', '.' },
            entry_maker = function(line)
                return {
                    value = line,
                    display = function(entry)
                        return ' ' .. line, { { { 1, 3 }, 'Directory' } }
                    end,
                    ordinal = line,
                }
            end,
            mappings = {
                default = function(directory)
                    require('oil').open(directory)
                end,
            }
      },
    bookmarks = {
      -- Available:
      --  * 'brave'
      --  * 'buku'
      --  * 'chrome'
      --  * 'chrome_beta'
      --  * 'edge'
      --  * 'firefox'
      --  * 'icecat'
      --  * 'qutebrowser'
      --  * 'safari'
      --  * 'vivaldi'
      --  * 'waterfox'
      selected_browser = 'icecat',

      -- Either provide a shell command to open the URL
      url_open_command = 'open',

      -- Or provide the plugin name which is already installed
      -- Available: 'vim_external', 'open_browser'
      url_open_plugin = nil,

      -- Show the full path to the bookmark instead of just the bookmark name
      full_path = true,

      -- Provide a custom profile name for IceCat browser
      icecat_profile_name = nil,

      -- Provide a custom profile name for Firefox browser
      firefox_profile_name = nil,

      -- Provide a custom profile name for Waterfox browser
      waterfox_profile_name = nil,

      -- Add a column which contains the tags for each bookmark for buku
      buku_include_tags = false,

      -- Provide debug messages
      debug = false,
    },
  }
})

-- Loading extensions must be done AFTER Telescope setup!

require("telescope").load_extension('file_browser')
-- require("telescope").load_extension('neoclip')
-- require("telescope").load_extension('macroscope')
require('telescope').load_extension('asynctasks')
require('telescope').load_extension('live_grep_args')
-- this is from yanky
require('telescope').load_extension('yank_history')
require('telescope').load_extension('cder')
require('telescope').load_extension('bookmarks')
require('telescope').load_extension('gtags')
require('telescope').load_extension('vim_bookmarks')
