return {
    {
	"folke/lazydev.nvim",
    },
  {
  	"folke/which-key.nvim",
		enabled = 1,
  },
	{
		'andymass/vim-matchup',
		dependencies = {
			"nvim-treesitter"
		},
	},
    {
        "andrewferrier/wrapping.nvim",
    },
	{
		'stevearc/aerial.nvim', -- outline (list of functions, chapters, ...)
		dependencies = {
			"nvim-treesitter" 
		},
		opts = {
			backends = { "treesitter", "lsp", "markdown", "man" },
			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
				vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
			end,
			disable_max_lines = 0,
		},
		keys = {
			{ "<localleader>a", '<cmd>AerialToggle!<CR>', desc = "Aerial toggle" },
		},
	},
  -- { 'stefandtw/quickfix-reflector.vim', },
	{
		'kevinhwang91/nvim-bqf',
		opts = {
			auto_enable = true,
			auto_resize_height = true, -- highly recommended enable
			preview = {
                auto_preview = false,
				win_height = 12,
				win_vheight = 12,
				delay_syntax = 80,
				border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
				show_title = false,
				should_preview_cb = function(bufnr, qwinid)
					local ret = true
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					local fsize = vim.fn.getfsize(bufname)
					if fsize > 100 * 1024 then
						-- skip file size greater than 100k
						ret = false
					elseif bufname:match('^fugitive://') then
						-- skip fugitive buffer
						ret = false
					end
					return ret
				end
			},
			-- make `drop` and `tab drop` to become preferred
			func_map = {
				drop = 'o',
				openc = 'O',
				split = '<C-s>',
				tabdrop = '<C-t>',
				-- set to empty string to disable
				tabc = '',
			},
		}
	},
	{
		'cshuaimin/ssr.nvim',
		opts = {
			min_width = 50,
			min_height = 5,
			max_width = 120,
			max_height = 25,
			keymaps = {
				close = "q",
				next_match = "n",
				prev_match = "N",
				replace_confirm = "<cr>",
				replace_all = "<leader><cr>",
			},
		},
		keys = {
			{ mode = { "n", "x" }, "<localleader>sr", function() require("ssr").open() end },
		},
	},
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
        -- ... options, see Configuration section below ...
        -- ... there are no required options atm...
        engine = 'astgrep', -- 'ripgrep' is default, but 'astgrep' can be specified...
      });
    end
  },
  {
    'dyng/ctrlsf.vim'
  },
  {
    'nvim-pack/nvim-spectre'
  },
  {
    'gabrielpoca/replacer.nvim'
  },
  {
		-- Finds root folder of current file
		'notjedi/nvim-rooter.lua',
		opts = {
			rooter_patterns = { '.git', '.hg', '.svn' },  -- To specify a concrete directory as root folder do this '=src'
			trigger_patterns = { '*' },
			manual = false,
		}
	},
	{
		'gbprod/yanky.nvim',
		opts = {
			ring = {
				history_length = 100,
				storage = "shada",
				sync_with_numbered_registers = true,
				cancel_event = "update",
			},
			preserve_cursor_position = {
				enabled = true,
			},
			highlight = {
				on_put = true,
				on_yank = true,
				timer = 500,
			},
			system_clipboard = {
				sync_with_ring = true,
			},
		},
		keys = {
			{mode = {"n","x"}, "p", "<Plug>(YankyPutAfter)"},
			{mode = {"n","x"}, "P", "<Plug>(YankyPutBefore)"},
			{mode = {"n","x"}, "gp", "<Plug>(YankyGPutAfter)"},
			{mode = {"n","x"}, "gP", "<Plug>(YankyGPutBefore)"},
			{"<c-n>", "<Plug>(YankyCycleForward)"},
			{"<c-p>", "<Plug>(YankyCycleBackward)"},
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			sections = {
				-- lualine_b = { "grapple" },
				lualine_c = {{ 'filename', path = 1 }},
			},
			inactive_sections = {
				-- lualine_b = { "grapple" },
				lualine_c = {{ 'filename', path = 1 }},
			}
		},
	},
	{
		'tex/vimpreviewpandoc',
		dependencies = {
			'prabirshrestha/async.vim',
		},
	},
  { 'skywind3000/asyncrun.vim' },
  {
    'tpope/vim-fugitive',
  },
  {
    'tanvirtin/vgit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons'
    },
    event = 'VimEnter',
    config = function() require('vgit').setup() end,
  },
  {
    'rbong/vim-flog'
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },
  { 'dhruvasagar/vim-table-mode',
    keys = { { "<localleader>tm", "<cmd>TableModeToggle<CR>", desc = "Toggle table mode" } },
    },
    {
    -- Nice multiple marks with \m
    'inkarkat/vim-mark',
    dependencies = { 'inkarkat/vim-ingo-library' }
    },
    {
    -- Nice bookmarks with mm, mi, mc, ma
    'MattesGroeger/vim-bookmarks',
    -- dependencies = {'tom-anders/telescope-vim-bookmarks.nvim'}
    },

    {
      'Joakker/lua-json5',
      build = './install.sh'
    },

{
  'stevearc/overseer.nvim',
  opts = {},
},


}
