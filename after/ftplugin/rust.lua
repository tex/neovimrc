local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<localleader>A",
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr, desc = "Rust LSP Code Action" }
)

vim.keymap.set(
  "n",
  "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({'hover', 'actions'})
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  "n",
  "<localleader>R",
  function()
    vim.cmd.RustLsp('relatedDiagnostics')
  end,
  { silent = true, buffer = bufnr, desc = "Rust LSP Related Diagnostics" }
)
vim.keymap.set(
  "n",
  "<localleader>D",
  function()
    vim.cmd.RustLsp('renderDiagnostic')
  end,
  { silent = true, buffer = bufnr, desc = "Rust LSP Show Diagnostic" }
)
vim.keymap.set(
  "n",
  "<localleader>E",
  function()
    vim.cmd.RustLsp('explainError')
  end,
  { silent = true, buffer = bufnr, desc = "Rust LSP Explain Error" }
)

vim.lsp.inlay_hint.enable(true)

