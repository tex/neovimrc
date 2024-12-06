
-- Disable 'swap files' (eg. .myfile.txt.swp) from being created
vim.opt.swapfile = false

-- incsearch has troubles with wilder and anyway it is not very useful
vim.opt.incsearch = false

vim.g.mapleader = "<Space>"
vim.g.maplocalleader = "\\"

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set spell for cmd-spell
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
-- Enables spellcheck for camel case words
vim.opt.spelloptions = "camel"

vim.opt.scrolloff = 10

vim.cmd.colorscheme("delek")

vim.opt.guifont = "FiraCode Nerd Font Mono:h14"
vim.opt.mouse = "a"

vim.opt.termguicolors = true
vim.opt.number = true
vim.cmd("hi LineNr ctermbg=NONE guibg=NONE")

vim.opt.clipboard = "unnamedplus"

vim.opt.conceallevel = 1
vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.undofile = true

require("config.lazy")

local wk = require("which-key")
wk.add({
	{ mode = "n", "<A-Up>", "<C-w>k" },
	{ mode = {"i", "t"}, "<A-Up>", "<C-\\><C-N><C-w>k" },
	{ mode = "n", "<A-Down>", "<C-w>j" },
	{ mode = {"i", "t"}, "<A-Down>", "<C-\\><C-N><C-w>j" },
	{ mode = "n", "<A-Left>", "<C-w>h" },
	{ mode = {"i", "t"}, "<A-Left>", "<C-\\><C-N><C-w>h" },
	{ mode = "n", "<A-Right>", "<C-w>l" },
	{ mode = {"i", "t"}, "<A-Right>", "<C-\\><C-N><C-w>l" },

	-- Move selected area up / down
	{ mode = "v", '<C-Up>', ":m '<-2<CR>gv=gv", desc = "Move selected region up" },
	{ mode = "v", '<C-Down>', ":m '>+1<CR>gv=gv", desc = "Move selected region down" },

	-- Remap p (paste) to not take what it pastes over
	{ mode = "x", "<space>p", '"_dP', desc = "Paste without copy" },

	-- To map <Esc> to exit terminal-mode
	{ mode = "t", "<Esc>", "<C-\\><C-n>" },

    { mode = "i", "<c-w>", "<c-s-w>" },
})

-- To simulate |i_CTRL-R| in terminal-mode
vim.cmd("tnoremap <expr> <C-R> '<C-\\><C-N>\"'.nr2char(getchar()).'pi'")

-- To close terminal of finished commands. Useful when using delta for diffs
vim.api.nvim_create_autocmd(
{'TermClose'}, {
	pattern = {'*'},
	callback = function()
		vim.cmd("execute 'bdelete! ' . expand('<abuf>')")
	end
})

--vim.api.nvim_create_autocmd( {'QuickFixCmdPost'}, { pattern = {'*'}, callback = function () vim.cmd("botright copen 8") end})

vim.api.nvim_create_autocmd(
    {'BufReadPost'}, {
    pattern = {'*'},
    callback = function()
        local ft = vim.opt_local.filetype:get()
        -- don't apply to git messages
        if (ft:match('commit') or ft:match('rebase')) then
            return
        end
        -- get position of last saved edit
        local markpos = vim.api.nvim_buf_get_mark(0,'"')
        local line = markpos[1]
        local col = markpos[2]
        -- if in range, go there
        if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
            vim.api.nvim_win_set_cursor(0,{line,col})
        end
    end
})

vim.keymap.set("c", "<space>", function()
  local mode = vim.fn.getcmdtype()
    if mode == "?" or mode == "/" then
      return ".*"
    else
      return " "
    end
  end, { expr = true })


