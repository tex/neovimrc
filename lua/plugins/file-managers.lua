return {
	{
		'stevearc/oil.nvim',
    lazy = false,
    enabled = true,
		keys = {
			{'<M-->', function() require('oil').open() end},
		},
		opts = { 
      default_file_explorer = true,
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
				["<C-v>"] = "actions.select_vsplit",
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
		},
	},
	{
		'simonmclean/triptych.nvim',
		keys = {
			{'-', ':Triptych<CR>', silent=true},
		},
		opts = {
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
				responsive_column_widths = {
					-- Keys are breakpoints, values are column widths
					-- A breakpoint means "when vim.o.columns >= x, use these column widths"
					-- Columns widths must add up to 1 after rounding to 2 decimal places
					-- Parent or child windows can be hidden by setting a width of 0
					['0'] = { 0, 0.5, 0.5 },
					['120'] = { 0.2, 0.3, 0.5 },
					['200'] = { 0.25, 0.25, 0.5 },
				},
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
}
}

