" !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/site/plugged')
" Plug 'ivechan/gtags.vim'

Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'bluz71/vim-moonfly-colors'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/playground'
Plug 'andymass/vim-matchup'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
" Has bugs, development stalled, not really using it anyway
" Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'molecule-man/telescope-menufacture'
Plug 'Zane-/cder.nvim'
Plug 'dhruvmanila/telescope-bookmarks.nvim', { 'tag': '*' }
" Uncomment if the selected browser is Firefox, Waterfox or buku
Plug 'kkharji/sqlite.lua'

Plug 'tex/telescope-gtags'

Plug 'inkarkat/vim-IndentConsistencyCop'
Plug 'tpope/vim-sleuth'

Plug 'echasnovski/mini.nvim'


Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/cmp-treesitter'
Plug 'lukas-reineke/cmp-rg'
Plug 'f3fora/cmp-spell'
Plug 'petertriho/cmp-git'
Plug 'onsails/lspkind-nvim'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" For ultisnips users.
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'



"Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
" Magit for neovim
Plug 'TimUntersberger/neogit'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'idanarye/vim-merginal'


Plug 'kyazdani42/nvim-web-devicons'

Plug 'cshuaimin/ssr.nvim'

function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
"Plug 'folke/noice.nvim'
"Plug 'MunifTanjim/nui.nvim'
"Plug 'rcarriga/nvim-notify'

"Plug 'smolck/command-completion.nvim', { 'branch': 'add-0.6-compat'}

"Plug 'elihunter173/dirbuf.nvim'
Plug 'stevearc/oil.nvim' " -- very good, but trying neo-tree
"Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'theblob42/drex.nvim'
" Plug 'nvim-neo-tree/neo-tree.nvim' " -- really good, but trying triptych
" Plug 'nvim-lua/plenary.nvim'
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
"   Plug 'MunifTanjim/nui.nvim'
Plug 'simonmclean/triptych.nvim'

"Plug 'sainnhe/edge'
"Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
"Plug 'savq/melange'

Plug 'glts/vim-magnum'		" Needed by vim-radical
Plug 'glts/vim-radical'		" Show and convert hex, dec, bin, oct: gA crd crx crb cro

" c[hange]s[urrond][what][to]
" d[elete]s[urround][what]
" y[ank]s[urround][target][what]
" virtual select S[what]
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'


"Plug 'AckslD/nvim-neoclip.lua'
Plug 'gbprod/yanky.nvim'

Plug 'dyng/ctrlsf.vim'

Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'GustavoKatel/telescope-asynctasks.nvim'

" Nice multiple marks with \m
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'

" Nice bookmarks with mm, mi, mc, ma
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tom-anders/telescope-vim-bookmarks.nvim'

" Plug 'ton/vim-bufsurf'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'anuvyklack/windows.nvim'
Plug 'anuvyklack/middleclass'
Plug 'anuvyklack/animation.nvim'


" Don't use it anymore
" Plug 'ptzz/lf.vim'
" Plug 'voldikss/vim-floaterm'

Plug 'ggandor/leap.nvim'
Plug 'ggandor/leap-spooky.nvim'

"Plug 'cbochs/portal.nvim'
"Plug 'cbochs/grapple.nvim'

Plug 'nvim-lualine/lualine.nvim'

Plug 'nullchilly/fsread.nvim'
" Plug 'edluffy/hologram.nvim'	" inline show images, but it seems not to work correctly...
" Plug 'ldelossa/nvim-ide'

Plug 'eandrju/cellular-automaton.nvim'

" Requires nodejs and yarn (guix install node)
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx yarn install' }
Plug 'tex/vimpreviewpandoc'
Plug 'prabirshrestha/async.vim'

" Finds root folder of current file
Plug 'notjedi/nvim-rooter.lua'

" Obsoleted by its author
" Plug 'phaazon/mind.nvim'
" Selyss picked up it:
Plug 'Selyss/mind.nvim'

Plug 'junegunn/rainbow_parentheses.vim'

Plug 'RaafatTurki/hex.nvim'

Plug 'stevearc/aerial.nvim'

Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

Plug 'dhruvasagar/vim-table-mode'

Plug 'ghassan0/telescope-glyph.nvim'
Plug 'xiyaowong/telescope-emoji.nvim'

Plug 'nullchilly/fsread.nvim'

Plug 'kevinhwang91/nvim-bqf'
Plug 'KaitlynEthylia/TreePin'

Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'tex/neogen'
Plug 'Marskey/telescope-sg'

" cargo install ast-grep
Plug 'Marskey/telescope-sg'

Plug 'jesseleite/nvim-macroni'

call plug#end()

" incsearch has troubles with wilder and anyway
" it is not very useful.
set noincsearch

nnoremap <A-Up> <C-w>k
nnoremap <A-Down> <C-w>j
nnoremap <A-Left> <C-w>h
nnoremap <A-Right> <C-w>l
tnoremap <A-Left> <C-\><C-N><C-w>h
tnoremap <A-Down> <C-\><C-N><C-w>j
tnoremap <A-Up> <C-\><C-N><C-w>k
tnoremap <A-Right> <C-\><C-N><C-w>l
inoremap <A-Left> <C-\><C-N><C-w>h
inoremap <A-Down> <C-\><C-N><C-w>j
inoremap <A-Up> <C-\><C-N><C-w>k
inoremap <A-Right> <C-\><C-N><C-w>l

lua << EOF

-- require("noice").setup({
--   lsp = {
--     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--     override = {
--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--       ["vim.lsp.util.stylize_markdown"] = true,
--       ["cmp.entry.get_documentation"] = true,
--     },
--   },
--   -- you can enable a preset for easier configuration
--   presets = {
--     bottom_search = false, -- use a classic bottom cmdline for search
--     command_palette = true, -- position the cmdline and popupmenu together
--     long_message_to_split = true, -- long messages will be sent to a split
--     inc_rename = false, -- enables an input dialog for inc-rename.nvim
--     lsp_doc_border = false, -- add a border to hover docs and signature help
--   },
-- })

require("lsp_lines").setup()
require('neogen').setup {
  enabled = true,
  languages = {
    cpp = {
      template = {
        annotation_convention = "doxygen_cpp"
      },
    },
  },
}

require('treepin').setup {
	hide_onscreen = true, -- Hide's the pin buffer when the text of the pin is visible.
	max_height = 30, -- Prevents the pin buffer from displaying when the pin is larger than x lines.
	position = 'relative', -- May be 'relative', 'top', or 'bottom'. Determines the position of the pin buffer within the window.
	icon = '>', -- The icon to display in the sign column at the top of the pin. Set to nil to prevent the sign column being used.
	zindex = 50, -- The Z-index of the pin buffer.
	seperator = nil, -- A single character that may be used as a seperator between the editing buffer and the pin buffer.
}
-- require('mini.completion').setup()
require('mini.ai').setup()
require('mini.comment').setup()
-- require('mini.surround').setup()
require('gitsigns').setup()
require('hex').setup({
  is_binary_file = function(binary_ext) return false end,
})
require('mind').setup()
-- require('mini.animate').setup()
require('neogit').setup()

-- require('hologram').setup{
--     auto_display = true -- WIP automatic markdown image display, may be prone to breaking
-- }
vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.keymap.set('n', '-', ':Triptych<CR>', { silent = true })
vim.keymap.set('n', '<M-->', function() require('oil').open() end)

-- Move selected area up / down
vim.keymap.set("v", '<C-Up>', ":m '<-2<CR>gv=gv")
vim.keymap.set("v", '<C-Down>', ":m '>+1<CR>gv=gv")

-- Remap p (paste) to not take what it pates over
vim.keymap.set("x", "<space>p", '"_dP')

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Set spell for cmd-spell
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

vim.opt.scrolloff = 10

vim.cmd [[let g:mkdp_preview_options = { 'uml': { 'server': 'http://localhost:8080', 'imageFormat': 'svg' }, 'disable_sync_scroll': 1}]]

-- Enables spellcheck for camel case words
vim.opt.spelloptions = "camel"
-- Ignores all capital letters misspelling
--vim.cmd([[
--fun! IgnoreCamelCaseSpell()
--    syn match myExCapitalWords +\<\w*[A-Z]\K*\>+ contains=@NoSpell
--endfun
--
--autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()
--]])

EOF

"lua require("neoclip").setup()
"lua require('dirbuf').setup { show_hidden = true, }


set guifont=FiraCode\ Nerd\ Font\ Mono:h14

set mouse=a

let g:nvcode_termcolors=256

let g:moonflyNormalFloat = 1
colorscheme moonfly " nvcode " Or whatever colorscheme you make

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
  set termguicolors
  hi LineNr ctermbg=NONE guibg=NONE
endif

let g:asyncrun_open = 6

" This will jump to the last known cursor position
autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
autocmd BufRead *
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

let g:bookmark_location_list = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1
" let g:BufSurfIgnore = '\[BufExplorer\]' " comma separated list of regexp matching buffer names that should be ignored in the bookkeeping process

"nmap <silent> <C-o> :BufSurfBack<CR>
"nmap <silent> <C-i> :BufSurfForward<CR>

set clipboard=unnamedplus


syntax enable

set completeopt=menu,menuone,noselect

set number

set conceallevel=1

" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>
" To simulate |i_CTRL-R| in terminal-mode:
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Prevent 'tilde backup files' (eg. myfile.txt~) from being created
set nobackup

" Disable 'swap files' (eg. .myfile.txt.swp) from being created
set noswapfile

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
au VimEnter * RainbowParentheses

set undofile


"fix for yankring and neovim
"let g:yankring_clipboard_monitor=0
