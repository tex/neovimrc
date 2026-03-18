return {
  "tex/snap",
  keys = {
    { "<leader>gbl", desc = "git branches", require("config.snap").git_branches },
    { "<leader>gl", desc = "git log", require("config.snap").git_log },
    { "<leader>gf", desc = "git files", require("config.snap").git_files },
    { "<leader>gs", desc = "git status", require("config.snap").git_status },
    { "<leader>fw", desc = "fd files", require("config.snap").fd_find },
    { "<leader>fq", desc = "rg grep", require("config.snap").rg_find },
    { "<leader>ft", desc = "ttag completion", require("config.snap").ttags_completion },
    { "<Leader>fd", desc = "tag definition", require("config.snap").ttags_def },
    { "<Leader>fr", desc = "tag references", require("config.snap").ttags_ref },
    { "<Leader>?", desc = "grep buffer", function ()
      local snap = require'snap'
      snap.run{
        producer = snap.get'consumer.fzy'(snap.get'producer.vim.currentbuffer'),
        select = snap.get'select.vim.currentbuffer'.select
      } end },
    { "<Leader>fo", desc = "buffers and old files", function ()
      local snap = require'snap'
      snap.config.file {
        prompt = "Buffers and Old Files",
        producer = snap.get'consumer.combine'(
          snap.get'producer.vim.buffer',
          snap.get'producer.vim.oldfile'
        )
      } () end },
    -- { "<Leader>fb", function () require'snap'.config.file {producer = "vim.buffer"}() end, desc = "buffers" },
    -- { "<Leader>fo", function () require'snap'.config.file {producer = "vim.oldfile" }() end, desc = "old files" },
  },
  config = function()
    -- this is needed for fzy
    pcall(require, 'luarocks.loader')

    -- Poor man's solution to resume last dialog.
    -- Only filter is kept and only first dialog, no steps remembered :(
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

    -- Now all usages of snap.run use the above definition and have their config stored,
    -- whether they are generated from snap.config, or just plain invocations of snap.run
    -- So you can now do all your setups as normal, but you can additionally now register
    -- a "last search" style setup
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


