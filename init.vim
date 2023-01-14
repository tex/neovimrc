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
Plug 'idanarye/vim-merginal'


Plug 'kyazdani42/nvim-web-devicons'

Plug 'cshuaimin/ssr.nvim'

function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }


"Plug 'smolck/command-completion.nvim', { 'branch': 'add-0.6-compat'}

"Plug 'elihunter173/dirbuf.nvim'
Plug 'stevearc/oil.nvim'
"Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

"Plug 'sainnhe/edge'
"Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
"Plug 'savq/melange'

Plug 'glts/vim-magnum'		" Needed by vim-radical
Plug 'glts/vim-radical'		" Show and convert hex, dec, bin, oct: gA crd crx crb cro

Plug 'tpope/vim-surround'	" c[hange]s[urrond][what][to] d[elete]s[urround][what]
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
Plug 'ldelossa/nvim-ide'

Plug 'eandrju/cellular-automaton.nvim'

" Requires nodejs and yarn (guix install node)
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx yarn install' }

" Finds root folder of current file
Plug 'notjedi/nvim-rooter.lua'

Plug 'phaazon/mind.nvim'

Plug 'junegunn/rainbow_parentheses.vim'

Plug 'RaafatTurki/hex.nvim'

Plug 'eandrju/cellular-automaton.nvim'

call plug#end()

" This disabled auto scroll synchronization in mardown-preview.nvim
" TODO: Make a function and keymap when in markdown buffer
" let g:mkdp_preview_options.disable_sync_scroll = !g:mkdp_preview_options.disable_sync_scroll

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

require('hex').setup()

require('mind').setup()
-- require('mini.animate').setup()
require('neogit').setup {}

-- require('hologram').setup{
--     auto_display = true -- WIP automatic markdown image display, may be prone to breaking
-- }
require('leap').add_default_mappings()
require('leap-spooky').setup({
  -- The yanked text will automatically be pasted at the cursor position
  -- if the unnamed register is in use.
  -- (Experimental feature - I'm thinking about the proper API for this.)
  yank_paste = false,
  keys = {
    -- For each scope, define a table like below, with separate affixes
    -- corresponding to "inner" and "around" objects.
    -- These will generate mappings for all given text objects, like:
    -- r{obj}, ar{obj}, R{obj}, aR{obj}, etc.
    forward      = nil,
    backward     = nil,
    window       = { i = 'r', a = 'ar' },
    cross_window = { i = 'R', a = 'aR' },
  },
  textobjects = {
    'iw', 'iW', 'is', 'ip', 'i[', 'i]', 'i(', 'i)', 'ib',
    'i>', 'i<', 'it', 'i{', 'i}', 'iB', 'i"', 'i\'', 'i`',
    'aw', 'aW', 'as', 'ap', 'a[', 'a]', 'a(', 'a)', 'ab',
    'a>', 'a<', 'at', 'a{', 'a}', 'aB', 'a"', 'a\'', 'a`',
  },
  -- Call-specific overrides for the Leap motion itself.
  -- E.g.: opts = { equivalence_classes = {} }
  opts = nil,
})

require('oil').setup {
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
      columns = {
        "icon",
        -- "permissions",
        "size",
        "mtime",
      },
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
      },
      -- Restore window options to previous values when leaving an oil buffer
      restore_win_options = true,
      -- Skip the confirmation popup for simple operations
      skip_confirm_for_simple_edits = false,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
      -- Additionally, if it is a string that matches "action.<name>",
      -- it will use the mapping at require("oil.action").<name>
      -- Set to `false` to remove a keymap
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-x>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["-"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
        ["gc"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
    }
vim.keymap.set('n', '-', function() require('oil').open() end)

EOF

"lua require("neoclip").setup()
"lua require('dirbuf').setup { show_hidden = true, }
lua require('gitsigns').setup()

set guifont=FiraCode\ Nerd\ Font\ Mono:h14

set mouse=a

lua << EOF
vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
EOF

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
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

let g:bookmark_location_list = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_auto_close = 1
" let g:BufSurfIgnore = '\[BufExplorer\]' " comma separated list of regexp matching buffer names that should be ignored in the bookkeeping process

"nmap <silent> <C-o> :BufSurfBack<CR>
"nmap <silent> <C-i> :BufSurfForward<CR>

lua << EOF

local default_opts = {noremap = true, silent = true}
vim.keymap.set('n', '<space>b', ':Telescope buffers<cr>', default_opts)
vim.keymap.set('n', '<space>m', ':Telescope oldfiles<cr>', default_opts)
vim.keymap.set('n', '<space>g', '"zyiw:Telescope live_grep_args default_text=<c-r>z<cr>', default_opts)
vim.keymap.set('v', '<space>g', '"zy:Telescope live_grep_args default_text=<c-r>z<cr>', default_opts)
vim.keymap.set("n", '<space>"', function() require("telescope").extensions.yank_history.yank_history() end)
vim.keymap.set('n', '<space>ff', function() require("telescope.builtin").find_files({ cwd = vim.fn.input("Find files Root > ", vim.fn.expand("%:h"), "dir") }) end)
vim.keymap.set('n', '<space>f', function() require("telescope.builtin").find_files({ }) end)
vim.keymap.set("n", '<space>d', function() require("telescope").extensions.cder.cder() end)
vim.keymap.set("n", 'gd', function() require("telescope").extensions.gtags.def({symbol = vim.fn.expand("<cword>")}) end)
vim.keymap.set("n", 'gr', function() require("telescope").extensions.gtags.ref({symbol = vim.fn.expand("<cword>")}) end)
vim.keymap.set("n", 'z=', function() require("telescope.builtin").spell_suggest() end)

-- Move selected area up / down
vim.keymap.set("v", '<C-Up>', ":m '<-2<CR>gv=gv")
vim.keymap.set("v", '<C-Down>', ":m '>+1<CR>gv=gv")

vim.keymap.set("x", "<space>p", '"_dP')

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

EOF

set clipboard=unnamedplus


syntax enable

" set completeopt=menu,menuone,noselect

" lua require('mini.completion').setup()
lua require('mini.ai').setup()
lua require('mini.comment').setup()


set completeopt=menu,menuone,noselect

lua <<EOF

-- Set spell for cmd-spell
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

vim.opt.scrolloff = 10

vim.cmd [[let g:mkdp_preview_options = { 'uml': { 'server': 'http://localhost:8080', 'imageFormat': 'svg' }}]]

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
set number

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

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
