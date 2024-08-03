return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,

		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = "all",
				sync_install = false,
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
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
				-- For all filetypes
				-- Note that setting an entry here replaces all other patterns for this entry.
				-- By setting the 'default' entry below, you can control which nodes you want to
				-- appear in the context window.
				default = {
					'class',
					'function',
					'method',
					'for',
					'while',
					'if',
					'switch',
					'case',
				},
				-- Example for a specific filetype.
				-- If a pattern is missing, *open a PR* so everyone can benefit.
				--   rust = {
				--       'impl_item',
				--   },
			},
			exact_patterns = {
				-- Example for a specific filetype with Lua patterns
				-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
				-- exactly match "impl_item" only)
				-- rust = true,
			},

			-- [!] The options below are exposed but shouldn't require your attention,
			--     you can safely ignore them.

			zindex = 20, -- The Z-index of the context window
		}
	},
	{
		'nvim-treesitter/playground',
	}
}


