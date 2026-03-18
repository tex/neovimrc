return {
  {
  "benomahony/oil-git.nvim",
  dependencies = { "stevearc/oil.nvim" },
    lazy = false,
    enabled = true,
    keys = {
      {'-', function() require('oil').open() end},
    },
    config = function()
      require("oil").setup({
        float = {
          preview_split = "right",
        },
        keymaps = {
          ["-"] = {"actions.close", mode = "n"},
          ["<Left>"] = {"actions.parent", mode = "n"},
          ["<Right>"] = {"actions.select", mode = "n"},
          ["<C-p>"] = {"actions.preview", opts = { split = "botright" } },
          ["gd"] = {desc = "toggle file details", function()
            if vim.b.oil_columns then
              vim.b.oil_columns = nil
              require("oil").set_columns({ "icon" })
            else
              vim.b.oil_columns = true
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            end
            end },
        },
        preview_win = {
          disable_preview = function(filepath)
            local is_image = require("config.image-preview").is_image(filepath)
            if is_image then
              return true, ""
            end
            local stat = vim.loop.fs_stat(filepath)
            if stat and stat.size > 100 * 1024 then
              return true, "File too large"
            end
            return false
          end,
        },
      })
    end,
  },
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    }
  }
}

