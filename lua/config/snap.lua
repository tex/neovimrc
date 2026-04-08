
function git_branches ()
  local snap = require'snap'
  snap.run {
    producer =-- snap.get'consumer.positions'(
      -- snap.get'consumer.score'(
      snap.get'consumer.fzy'(
        snap.get'producer.extcmd'(
          { cmd = "git",
            args = { "branch", "--sort" ,"-committerdate", "--format", "%(refname:short)" },
            parse = snap.get'common.string'.split,
            ignore_empty_filter = false,
            ignore_filter = true,
          })
      ),--),
    select = snap.get'select.git',
    --views = { snap.get'preview.git.log' },
  }
end

function git_log ()
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

function git_files ()
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

function git_status ()
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

function ttags_completion ()
  local snap = require'snap'
  snap.run {
    producer = snap.get'consumer.positions'(
      snap.get'consumer.score'(
        snap.get'producer.extcmd'(
          { cmd = "ttags",
            args = { "-c" },
            parse = snap.get'common.string'.split,
            ignore_empty_filter = false,
          }),
        function(selection) return snap.get'common.vimgrep.parse'(selection).filename end)),
    prompt = "tag completion>",
    initial_filter = snap.config.get_initial_filter({filter_with = "cword"}),
    steps = {{
      consumer = snap.get'consumer.fzy',
      config = {prompt = "tag fzy>", initial_filter = function (filter) return string.gsub(filter, "%%", "") end}
    }},
    select = ttags_def,
  }
end

function ttags_def (result)
  local snap = require'snap'
  snap.run {
    producer = snap.get'consumer.score'(
        snap.get'producer.extcmd'(
          { cmd = "ttags",
            args = { "-d" },
            parse = snap.get'common.string'.split,
            ignore_empty_filter = false,
          }),
        function(selection) return snap.get'common.vimgrep.parse'(selection).filename end),
    prompt = "tag def>",
    initial_filter = (function()
      if result then return tostring(result)
      else return snap.config.get_initial_filter({filter_with = "cword"}) end
    end)(),
    steps = {{
      consumer = snap.get'consumer.fzy',
      config = {prompt = "tag fzy>", initial_filter = ""}
    }},
    select = snap.get'select.grep'.select,
    multiselect = snap.get'select.grep'.multiselect,
    views = {snap.get'preview.grep'},
  }
end

function ttags_ref ()
  local snap = require'snap'
  snap.run {
    producer = snap.get'consumer.score'(
        snap.get'producer.extcmd'(
          { cmd = "ttags",
            args = { "-r" },
            parse = snap.get'common.string'.split,
            ignore_empty_filter = false,
          }),
        function(selection) return snap.get'common.vimgrep.parse'(selection).filename end),
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
end

function rg_find ()
  vim.fn.setreg('+', vim.fn.expand("<cword>"))
  local snap = require'snap'
  snap.setcwd(require'oil'.get_current_dir())
  snap.run {
    prompt = "grep (rg)>",
    -- initial_filter = snap.config.get_initial_filter({filter_with = "cword"}),
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
    steps = {{
      consumer = snap.get'consumer.fzy',
      config = {prompt = "fzy>", initial_filter = function (filter) return "" end}
    }},
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = { snap.get'preview.vimgrep' },
  }
end

-- By default it finds files, but user can change
-- params (C-p) to 'd' to find directories
function fd_find ()
  local snap = require'snap'
  snap.setcwd(require'oil'.get_current_dir())
  snap.setparams("f")
  snap.run {
    prompt = "find (fd)>",
    producer =-- snap.get'consumer.positions'(
      snap.get'consumer.score'(
        snap.get'producer.extcmd'(
          { cmd = "fd",
            args = { "--no-ignore-vcs", "-t" },
            parse = snap.get'common.string'.split,
            ignore_empty_filter = false,
          })
      ),--),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = { snap.get'preview.file' },
  }
end

local M = {}

M.git_branches = git_branches
M.git_log = git_log
M.git_files = git_files
M.git_status = git_status

M.rg_find = rg_find
M.fd_find = fd_find

M.ttags_completion = ttags_completion
M.ttags_def = ttags_def
M.ttags_ref = ttags_ref

return M

