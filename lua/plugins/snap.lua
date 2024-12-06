return {
	"tex/snap",
	keys = {
		{ "<leader>ft", function ()
			local snap = require'snap'
			snap.run {
				producer = snap.get'consumer.positions'(
				snap.get'consumer.score'(
				snap.get'producer.tags.symbol')),
				prompt = "tag completion>",
				initial_filter = snap.config.get_initial_filter({filter_with = "cword"}),
				steps = {{
					consumer = snap.get'consumer.fzy',
					config = {prompt = "tag fzy>", initial_filter = function (filter) return string.gsub(filter, "%%", "") end}
				}},
				select = function (result)
					snap.run {
						producer = snap.get'consumer.score'(snap.get'producer.tags.def'),
						initial_filter = tostring(result),
						prompt = "tag def>",
						steps = {{
							consumer = snap.get'consumer.fzy',
							config = {prompt = "tag fzy>", initial_filter = ""}
						}},
						select = snap.get'select.grep'.select,
						multiselect = snap.get'select.grep'.multiselect,
						views = {snap.get'preview.grep'},
					} end,
				}
			end,
			desc = "tag completion",
		},
		{ "<Leader>fd", function ()
			local snap = require'snap'
			snap.run {
				producer = snap.get'consumer.score'(
				snap.get'producer.tags.def'),
				prompt = "tag def>",
				initial_filter = snap.config.get_initial_filter({filter_with = "cword"}),
				steps = {{
					consumer = snap.get'consumer.fzy',
					config = {prompt = "tag fzy>", initial_filter = ""}
				}},
				select = snap.get'select.grep'.select,
				multiselect = snap.get'select.grep'.multiselect,
				views = {snap.get'preview.grep'},
			}
			end,
			desc = "tag definition",
		},
		{ "<Leader>fr", function ()
				local snap = require'snap'
				snap.run {
					producer = snap.get'consumer.score'(snap.get'producer.tags.ref'),
					prompt = "tag ref>",
					initial_filter = snap.config.get_initial_filter({filter_with = "cword"}),
					steps = {{
						consumer = snap.get'consumer.fzy',
						config = {prompt = "tag fzy>", initial_filter = function (filter) return "" end}
					}},
					select = snap.get'select.grep'.select,
					multiselect = snap.get'select.grep'.multiselect,
					views = {snap.get'preview.grep'},
				}
			end,
			desc = "taf references",
		},
		{ "<Leader><Leader>", function ()
				local snap = require'snap'
				snap.run {
					--producer = snap.get'consumer.fzy'(snap.get'consumer.cache'(snap.get'producer.fd.file')),
					producer = snap.get'consumer.fzy'(snap.get'consumer.cache'(snap.get'producer.ripgrep.file')),
					select = snap.get'select.file'.select,
					multiselect = snap.get'select.vimgrep'.multiselect,
					views = {snap.get'preview.file'},
                    layout = function()
                        local fn = snap.get'layout'['%centered']
                        return fn(1.0, 1.0)
                    end,
				}
			end,
			desc = "find files",
		},
		{ "<Leader>_", function ()
				local snap = require'snap'
				snap.run{
					producer = snap.get'consumer.fzy'(snap.get'producer.vim.currentbuffer'),
					select = snap.get'select.vim.currentbuffer'.select
				}
			end,
			desc = "grep buffer",
		},
		{ "<Leader>fb", function () require'snap'.config.file {producer = "vim.buffer"}() end, desc = "buffers" },
		{ "<Leader>fo", function () require'snap'.config.file {producer = "vim.oldfile" }() end, desc = "old files" },
		{ "<Leader>ff", function ()
				local snap = require'snap'
				snap.run {
					producer = (snap.get'producer.ripgrep.vimgrep'),
					prompt = "grep>",
					initial_filter = snap.config.get_initial_filter({filter_with = "cword"}),
					steps = {{
						consumer = snap.get'consumer.fzy',
						config = {prompt = "tag fzy>", initial_filter = function (filter) return "" end}
					}},
					select = snap.get'select.vimgrep'.select,
					multiselect = snap.get'select.vimgrep'.multiselect,
					views = {snap.get'preview.vimgrep'},
				}
      end, desc = "grep files with cword"},
	},
	config = function()
		-- this is needed for fzy
		pcall(require, 'luarocks.loader')

		local snap = require'snap'
		local tbl = require("snap.common.tbl")
		-- Here we are storing the old version of snap.run
		local run = snap.run
		-- Here we will store each config that is passed to snap.run
		local last_config = nil
		-- Here we are overriding snap.run, this isn't the most sane thing to do but it will work
		snap.run = function(config)
			last_config = config
			local function on_update(filter)
				if config.on_update then
					config.on_update(filter)
				end
				last_config.initial_filter = filter
			end
			run(tbl.merge(config, { on_update = on_update }))
		end

		-- Now all usages of snap.run use the above definition and have their config stored, whether they are generated from snap.config, or just plain invocations of snap.run
		-- So you can now do all your setups as normal, but you can additionally now register a "last search" style setup
		local wk = require("which-key")
		wk.add({
			{
				"<Leader>i",
				function () if last_config then snap.run(last_config) end end,
				desc = "resume last",
			},
		})

	end,
}


