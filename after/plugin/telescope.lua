local actions = require("telescope.actions")
local action_state = require('telescope.actions.state')
local transform_mod = require("telescope.actions.mt").transform_mod
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values

local ns = vim.api.nvim_create_namespace("")

local my_previewer = function()
  local jump_to_line = function (self, bufnr, entry)
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    vim.api.nvim_buf_add_highlight(bufnr, ns, "TelescopePreviewLine", entry.lnum-1, 0, -1)
    pcall(vim.api.nvim_win_set_cursor, self.state.winid, { entry.lnum, 0 })
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd "norm! zt"
    end)
  end
  return previewers.new_buffer_previewer {
    title = "Test previewer",
    get_buffer_by_name = function (self, entry)
      return entry.path
    end,
    define_preview = function (self, entry)
      local p = entry.path
      return conf.buffer_previewer_maker(p, self.state.bufnr, {
        bufname = self.state.bufname,
        winid = self.state.winid,
        callback = function(bufnr)
          jump_to_line(self, bufnr, entry)
        end,
      })
    end,
  }
end

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

local function _if(bool, val1, val2)
  if bool then return val1 else return val2 end
end

-- get text selected in visual mode
local function get_visual()
  local _, ls, cs = unpack(vim.fn.getpos('v'))
  local _, le, ce = unpack(vim.fn.getpos('.'))
  return vim.api.nvim_buf_get_text(
    0,
    _if(ls-1 > le-1, le-1, ls-1),
    _if(cs-1 > ce, ce, cs-1),
    _if(ls-1 > le-1, ls-1, le-1),
    _if(cs-1 > ce, cs-1, ce),
    {}
  )[1]
end


require'telescope'.setup({
  defaults = {
    generic_sorter = require('mini.fuzzy').get_telescope_sorter,
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
        --['<C-BS>'] = function() vim.api.nvim_input('<C-w>') end,
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
find_files = {
            find_command = { "fd", "--color", "never" }
        },
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
        ast_grep = {
            command = {
                "sg",
                "--json=stream",
            }, -- must have --json=stream
            grep_open_files = false, -- search in opened files
            lang = nil, -- string value, specify language for ast-grep `nil` for default
        }
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
require('telescope').load_extension('glyph')
require('telescope').load_extension('emoji')
require('telescope').load_extension('menufacture')
require('telescope').load_extension('ast_grep')


vim.keymap.set("n", '<space><space>', function() require("telescope.builtin").resume() end)
vim.keymap.set("n", '<space>b', function() require("telescope.builtin").buffers() end)
vim.keymap.set("n", '<space>m', function() require("telescope.builtin").oldfiles() end)
vim.keymap.set('n', '<space>g', function() require("telescope").extensions.live_grep_args.live_grep_args() end)
vim.keymap.set('n', '<space>gg', function() require("telescope").extensions.live_grep_args.live_grep_args({cwd = vim.fn.input("Grep files Root > ", string.gsub(vim.fn.expand("%:h"), "oil://", ""), "dir") }) end)
vim.keymap.set('n', '<space>G', function() require("telescope").extensions.live_grep_args.live_grep_args({default_text = vim.fn.expand("<cword>") }) end)
vim.keymap.set('v', '<space>g', function() require("telescope").extensions.live_grep_args.live_grep_args({default_text = get_visual() }) end)
vim.keymap.set('v', '<space>G', function() require("telescope").extensions.live_grep_args.live_grep_args({default_text = get_visual() }) end)
vim.keymap.set("n", '<space>\'', function() require("telescope").extensions.yank_history.yank_history() end)
vim.keymap.set("i", '<A-\'>', function() require("telescope").extensions.yank_history.yank_history() end)
vim.keymap.set('n', '<space>ff', function() require("telescope").extensions.menufacture.find_files({ cwd = vim.fn.input("Find files Root > ", string.gsub(vim.fn.expand("%:h"), "oil://", ""), "dir") }) end)
vim.keymap.set('n', '<space>f', function() require("telescope").extensions.menufacture.find_files({ }) end)
vim.keymap.set('n', '<space>F', function() require("telescope").extensions.menufacture.find_files({ search_file = vim.fn.expand("<cword>") }) end)
vim.keymap.set("n", '<space>d', function() require("telescope").extensions.cder.cder() end)
vim.keymap.set("n", 'gd', function() require("telescope").extensions.gtags.def({symbol = vim.fn.expand("<cword>")}) end)
vim.keymap.set("n", 'gr', function() require("telescope").extensions.gtags.ref({symbol = vim.fn.expand("<cword>")}) end)
vim.keymap.set("n", 'z=', function() require("telescope.builtin").spell_suggest() end)
vim.keymap.set("n", '<space>/', function() require("telescope.builtin").current_buffer_fuzzy_find({ default_text = vim.fn.expand("<cword>") }) end)

vim.keymap.set('n', '<space>h', require('telescope').extensions.menufacture.live_grep)
-- vim.keymap.set('n', '<leader>sw', require('telescope').extensions.menufacture.grep_string)

require('browser_bookmarks').setup({
  config_dir = "/home/milan/.mozilla/icecat/",
  full_path = true,
  selected_browser = "firefox",
  url_open_command = "open"
})
