return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,

		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = "all",
				sync_install = true,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },  
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = "grc",
						node_decremental = "<BS>",
					},
				},
				matchup = {
					enable = true,              -- mandatory, false will disable the whole extension
					-- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
				},
			}
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            multiwindow = true,
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            line_numbers = false,
			zindex = 20, -- The Z-index of the context window
		}
	},
	{
		'nvim-treesitter/playground',
	}
}


