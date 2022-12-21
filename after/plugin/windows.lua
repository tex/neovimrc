require("windows").setup{
  autowidth = {
    enable = false,
    winwidth = 5,
    filetype = {
      help = 2,
    },
  },
  ignore = {
    buftype = { "quickfix" },
    filetype = { "NvimTree", "neo-tree", "undotree", "NeogitStatus" }
  },
  animation = {
    enable = true,
    duration = 300,
    fps = 30,
    easing = "in_out_sine"
  }
}

vim.keymap.set('n', '<C-w>z', '<Cmd>WindowsMaximize<CR>')
