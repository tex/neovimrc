vim.opt_local.listchars:remove("tab:>·")
vim.opt_local.listchars:append("tab:  ")

vim.keymap.set("n", "<C-S>", function() require("dirbuf").enter("split") end, { buffer = true })
vim.keymap.set("n", "<C-X>", function() require("dirbuf").enter("vsplit") end, { buffer = true })
vim.keymap.set("n", "<C-T>", function() require("dirbuf").enter("tabedit") end, { buffer = true })
vim.keymap.set("n", "<BS>", '<Plug>(dirbuf_up)', { buffer = true })
vim.keymap.set("n", "-", function() require("dirbuf").quit() end, { buffer = true })

