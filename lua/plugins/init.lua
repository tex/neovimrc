return {
	"folke/lazydev.nvim",
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
--{
--  'stevearc/quicker.nvim',
--  event = "FileType qf",
--  ---@module "quicker"
--  ---@type quicker.SetupOptions
--  opts = {},
--},
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
-- {
--   'tanvirtin/vgit.nvim',
--   requires = {
--     'nvim-lua/plenary.nvim'
--   }
-- },
  {
    'rbong/vim-flog'
  },
  {
       'sindrets/diffview.nvim'
  },
{
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    --"nvim-telescope/telescope.nvim", -- optional
    --"ibhagwan/fzf-lua",              -- optional
    "echasnovski/mini.pick",         -- optional
    --"folke/snacks.nvim",             -- optional
  },
},
  { 'dhruvasagar/vim-table-mode',
    keys = { { "<localleader>t", "<cmd>TableModeToggle<CR>", desc = "Toggle table mode" } },
  },
  {
    'inkarkat/vim-mark',
    init = function()
        vim.g.mw_no_mappings = true
    end,
    keys = {
            { mode = { "n" }, desc = "MarkSet",               ",,", "<Plug>MarkSet" },
            { mode = { "x" }, desc = "MarkSet",               ",,", "<Plug>MarkSet" },
            { mode = { "n" }, desc = "MarkPartialWord",       ",p", "<Plug>MarkPartialWord" },
            { mode = { "n" }, desc = "MarkRegex",             ",r", "<Plug>MarkRegex" },
            { mode = { "x" }, desc = "MarkRegex",             ",r", "<Plug>MarkRegex" },
            { mode = { "n" }, desc = "MarkClear",             ",n", "<Plug>MarkClear" },
            { mode = { "n" }, desc = "MarkAllClear",          ",c", "<Plug>MarkAllClear" },
            { mode = { "n" }, desc = "MarkSearchCurrentNext", ",*", "<Plug>MarkSearchCurrentNext" },
            { mode = { "n" }, desc = "MarkSearchCurrentPrev", ",#", "<Plug>MarkSearchCurrentPrev" },
            { mode = { "n" }, desc = "MarkSearchAnyNext",     ",/", "<Plug>MarkSearchAnyNext" },
            { mode = { "n" }, desc = "MarkSearchAnyPrev",     ",?", "<Plug>MarkSearchAnyPrev" },
            { mode = { "n" }, desc = "MarkSearchNext",        ",*", "<Plug>MarkSearchNext" },
            { mode = { "n" }, desc = "MarkSearchPrev",        ",#", "<Plug>MarkSearchPrev" },
    },
    dependencies = { 'inkarkat/vim-ingo-library' }
  },
  {
    -- Nice bookmarks with mm, mi, mc, ma
    'MattesGroeger/vim-bookmarks',
    -- dependencies = {'tom-anders/telescope-vim-bookmarks.nvim'}
  },
  {
        'wojciech-kulik/filenav.nvim',
        config = function()
            require("filenav").setup({
                next_file_key = "<M-i>",
                prev_file_key = "<M-o>",
                max_history = 100,
                remove_duplicates = false,
            })
        end,
  },
{
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  -- {
  --   'akinsho/toggleterm.nvim',
  --   version = "*",
  --   config = true
  -- },
  {
    "numToStr/FTerm.nvim",
    event = { 'BufEnter' },
    opts = {
      border = 'double',
      dimensions  = {
        height = 0.9,
        width = 0.9,
      },
    },
    keys = {
      { mode = {'n'}, '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>' },
      { mode = {'t'}, '<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>' },
    },
  }
  , {
    "HiPhish/rainbow-delimiters.nvim",
  },
-- {
--   "dmtrKovalenko/fff.nvim",
--   build = "cargo build --release",
--   opts = {
--     -- pass here all the options
--   },
--   keys = {
--     {
--       "<leader>fff", -- try it if you didn't it is a banger keybinding for a picker
--       function()
--         require("fff").toggle()
--       end,
--       desc = "Toggle FFF",
--     },
--   },
-- },
-- {
--   "A7Lavinraj/fyler.nvim",
--   dependencies = { "echasnovski/mini.icons" },
--   branch = "main",
--   opts = {}
-- },
{
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
    })
    vim.cmd('colorscheme github_light')
  end,
},
{
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
},
--{
--    "DamianVCechov/hexview.nvim",
--    config = function()
--        require("hexview").setup()
--    end
--},
{
  'glts/vim-radical',
  dependencies = { 'glts/vim-magnum' },
},
}

