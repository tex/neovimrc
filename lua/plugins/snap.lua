return {
  "tex/snap",
  keys = {
    -- for tmux sessions
    -- tmux list-sessions -F #S

    { "<leader>gbl", function ()
      local snap = require'snap'
      snap.run {
        producer =-- snap.get'consumer.positions'(
          -- snap.get'consumer.score'(
            snap.get'consumer.fzy'(
              snap.get'producer.extcmd'(
              { cmd = "git",
                args = { "branch", "--sort", "-committerdate", '--format "%refname:short)"' },
                -- parse = snap.get'common.string'.split,
                parse = function (line)
                  local log_entries = snap.get'common.string'.split(line)
                  return vim.tbl_map(snap.get'common.git.parse-log', log_entries)
                end,
                ignore_empty_filter = false,
                ignore_filter = true,
              })
          ),--),
        select = snap.get'select.git',
        --multiselect = snap.get'select.file'.multiselect,
        views = { snap.get'preview.git.log' },
      }
    end
    },
    { "<leader>gl", function ()
      local snap = require'snap'
      snap.run {
        producer =-- snap.get'consumer.positions'(
          -- snap.get'consumer.score'(
            snap.get'consumer.fzy'(
              snap.get'producer.extcmd'(
              { cmd = "git",
                args = { "log", "--oneline" },
                -- parse = snap.get'common.string'.split,
                parse = function (line)
                  local log_entries = snap.get'common.string'.split(line)
                  return vim.tbl_map(snap.get'common.git.parse-log', log_entries)
                end,
                ignore_empty_filter = false,
                ignore_filter = true,
              })
          ),--),
        select = snap.get'select.git',
        --multiselect = snap.get'select.file'.multiselect,
        views = { snap.get'preview.git.log' },
      }
    end
    },
    { "<leader>gf", function ()
      local snap = require'snap'
      snap.run {
        producer =-- snap.get'consumer.positions'(
          -- snap.get'consumer.score'(
            snap.get'producer.extcmd'(
              { cmd = "git",
                args = { "ls-files" },
                parse = snap.get'common.string'.split,
                ignore_empty_filter = false,
                ignore_filter = true,
              })
            , --),--),
        select = snap.get'select.file'.select,
        multiselect = snap.get'select.file'.multiselect,
        views = { snap.get'preview.file' },
      }
    end
    },
    { "<leader>gs", function ()
      local snap = require'snap'
      local parse_git_status = function(selection) return {
        -- [1] is status (M/D/??/...)
        -- [2] is filename
        filename = snap.get'common.string'.split(selection, " ")[2]
      } end
      snap.run {
        producer =-- snap.get'consumer.positions'(
          -- snap.get'consumer.score'(
            snap.get'producer.extcmd'(
              { cmd = "git",
                args = { "status", "--porcelain" },
                parse = snap.get'common.string'.split,
                ignore_empty_filter = false,
                ignore_filter = true,
              })
            , --),--),
        select = snap.get'select.common.file'(parse_git_status),
        multiselect = snap.get'select.common.multifile'(parse_git_status),
        views = { snap.get'preview.git.status' },
      }
    end
    },
    { "<leader>fw", function ()
      local snap = require'snap'
      snap.run {
        producer =-- snap.get'consumer.positions'(
          snap.get'consumer.score'(
            snap.get'producer.extcmd'(
              { cmd = "fd",
                args = { "--no-ignore-vcs", "-t" }, -- , "f" }, -- "d"
                parse = snap.get'common.string'.split,
                ignore_empty_filter = false,
              })
            ),--),
        select = snap.get'select.file'.select,
        multiselect = snap.get'select.file'.multiselect,
        views = { snap.get'preview.file' },
      }
    end
    },
    { "<leader>fq", function ()
      local snap = require'snap'
      snap.run {
        producer =-- snap.get'consumer.positions'(
          snap.get'consumer.score'(
            snap.get'producer.extcmd'(
              { cmd = "rg",
                args = { "--line-buffered", "-M", "100", "--vimgrep", "-S" },
                -- args = { "--line-buffered", "--files" }, -- for files
                -- args = { "--line-buffered", "-M 100", "--no-heading", "--column" } -- for line args
                parse = snap.get'common.string'.split,
                ignore_empty_filter = true,
              }),
            function(selection) return snap.get'common.vimgrep.parse'(selection).filename end),--),
        select = snap.get'select.vimgrep'.select,
        multiselect = snap.get'select.vimgrep'.multiselect,
        views = { snap.get'preview.vimgrep' },
      }
    end
    },
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
    { "<leader>fF", function ()
      local snap = require'snap'
      local dir = vim.fn.input("Hello>", "", "dir")
      vim.api.nvim_set_current_dir(dir)
      snap.run {
        --producer = snap.get'consumer.fzy'(snap.get'consumer.cache'(snap.get'producer.fd.file')),
        producer = snap.get'consumer.fzy'(snap.get'producer.ripgrep.file'),
        select = snap.get'select.file'.select,
        multiselect = snap.get'select.file'.multiselect,
        views = {snap.get'preview.file'},
        layout = function()
          local fn = snap.get'layout'['%centered']
          return fn(0.9, 0.7)
        end,
      }
    end
    },
    { "<leader>ft", function ()
      local snap = require'snap'
      --vim.fn.filereadable("GTAGS") ".ttags.entry.bin"
      --ttags / global --result=grep    / def -d ref -f symbols -c
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
        -- producer = snap.get'consumer.fzy'(snap.get'producer.ripgrep.file'),
        producer = snap.get'producer.ripgrep.file',
        select = snap.get'select.file'.select,
        multiselect = snap.get'select.file'.multiselect,
        views = {snap.get'preview.file'},
        layout = function()
          local fn = snap.get'layout'.top
          return fn()
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


