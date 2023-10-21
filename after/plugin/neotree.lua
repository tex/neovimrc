require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["<Right>"] = "open",
        ["<Left>"] = "close_node",
        ["_"] = function() vim.cmd("Neotree toggle") end,
      }
    }
  }
})

vim.keymap.set('n', '-', function() vim.cmd("Neotree toggle current reveal_force_cwd") end)
vim.keymap.set('n', '_', function() vim.cmd("Neotree toggle") end)
vim.keymap.set('n', '\\g', function() vim.cmd("Neotree float git_status") end)

-- nnoremap \f :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
-- nnoremap \b :Neotree toggle show buffers right<cr>

