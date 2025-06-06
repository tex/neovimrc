return {
  "harrisoncramer/gitlab.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
        { "sindrets/diffview.nvim",
            config = function()
                require("diffview").setup({
                    view = { default = { layout = "diff2_vertical" } },
                    merge_tool = { layout = "diff3_vertical" },
                    file_history = { layout = "diff2_vertical" },
                })
            end,
        },
    "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
    "nvim-tree/nvim-web-devicons" -- Recommended but not required. Icons in discussion tree.
  },
  enabled = true,
  build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
  config = function()
    require("gitlab").setup({
      debug = { request = true, response = true, gitlab_request = true, gitlab_response = true, },
      log_path = "/home/msvobod/gitlab.nvim.log", -- Log path for the Go server
      keymaps = { discussion_tree = { refresh_data = "<leader>r" } },
      discussion_signs = {
        enabled = true, -- Show diagnostics for gitlab comments in the reviewer
        skip_resolved_discussion = false, -- Show diagnostics for resolved discussions
        severity = vim.diagnostic.severity.INFO, -- ERROR, WARN, INFO, or HINT
        virtual_text = true, -- Whether to show the comment text inline as floating virtual text
        use_diagnostic_signs = true, -- Show diagnostic sign (depending on the `severity` setting, e.g., I for INFO) along with the comment icon
        priority = 100, -- Higher will override LSP warnings, etc
        icons = {
          comment = "→|",
          range = " |",
        },
      },
    })
    local gitlab = require("gitlab")
    local gitlab_server = require("gitlab.server")
    local wk = require("which-key")
    wk.add({
     { mode = "n", "glb", gitlab.choose_merge_request, desc = "choose_merge_request" },
     { mode = "n", "glr", gitlab.review, desc = "review" },
     { mode = "n", "gls", gitlab.summary, desc = "summary" },
     { mode = "n", "glA", gitlab.approve, desc = "approve" },
     { mode = "n", "glR", gitlab.revoke, desc = "revoke" },
     { mode = "n", "glc", gitlab.create_comment, desc = "create_comment" },
     { mode = "v", "glc", gitlab.create_multiline_comment, desc = "create_multiline_comment" },
     { mode = "v", "glC", gitlab.create_comment_suggestion, desc = "create_comment_suggestion" },
     { mode = "n", "glO", gitlab.create_mr, desc = "create_mr" },
     { mode = "n", "glm", gitlab.move_to_discussion_tree_from_diagnostic, desc = "move_to_discussion_tree_from_diagnostic" },
     { mode = "n", "gln", gitlab.create_note, desc = "create_note" },
     { mode = "n", "gld", gitlab.toggle_discussions, desc = "toggle_discussions" },
     { mode = "n", "glaa", gitlab.add_assignee, desc = "add_assignee" },
     { mode = "n", "glad", gitlab.delete_assignee, desc = "delete_assignee" },
     { mode = "n", "glla", gitlab.add_label, desc = "add_label" },
     { mode = "n", "glld", gitlab.delete_label, desc = "delete_label" },
     { mode = "n", "glra", gitlab.add_reviewer, desc = "add_reviewer" },
     { mode = "n", "glrd", gitlab.delete_reviewer, desc = "delete_reviewer" },
     { mode = "n", "glp", gitlab.pipeline, desc = "pipeline" },
     { mode = "n", "glo", gitlab.open_in_browser, desc = "open_in_browser" },
     { mode = "n", "glM", gitlab.merge, desc = "merge" },
     { mode = "n", "glu", gitlab.copy_mr_url, desc = "copy_mr_url" },
     { mode = "n", "glP", gitlab.publish_all_drafts, desc = "publish_all_drafts" },
     { mode = "n", "glD", gitlab.toggle_draft_mode, desc = "toggle_draft_mode" },
    })
  end,
}
