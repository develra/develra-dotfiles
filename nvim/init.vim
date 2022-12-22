" Use Vim settings, rather then Vi settings (much better!).
"" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set clipboard=unnamedplus       "use system clipboard by default
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set autoread                    "Reload files changed outside vim
set foldmethod=indent           "Fold files based on indentation
set hidden                      "let buffer be open with no window 
let mapleader=" "               "Change leader to spacebar

autocmd FileType qf setlocal wrap

" ===============  Plugin Configuration ================ 
filetype plugin on
" Python
let g:python3_host_prog='usr/bin/python3'
" Golden Ratio
let g:golden_ratio_exclude_nonmodifiable = 1
let g:golden_ratio_autocommand = 0
" MRU
let MRU_Max_Entries = 10000
" NerdTree
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 50
let NERDTreeQuitOnOpen=1
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

augroup CloseLoclistWindowGroup
   autocmd!
   autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
" "make tab cycle autocomplete suggestions forward
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
 
 "make shift-tab cycle autocomplete suggestions backward
 inoremap <silent><expr> <S-Tab>
       \ pumvisible() ? "\<C-p>" : "\<S-TAB>"
" CtrlP
" ================ Initialize Plugins ================
"
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('morhetz/gruvbox')
  call dein#add('roman/golden-ratio')
  call dein#add('pangloss/vim-javascript')
  call dein#add('herringtondarkholme/yats.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('yegappan/mru')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('vim-test/vim-test')
  call dein#add('junegunn/vim-easy-align')
  if has('nvim')
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('nvim-lua/plenary.nvim')
    call dein#add('kkharji/sqlite.lua')
    call dein#add('hrsh7th/nvim-cmp')
    call dein#add('hrsh7th/cmp-nvim-lsp')
    call dein#add('hrsh7th/cmp-buffer')
    call dein#add('hrsh7th/cmp-path')
    call dein#add('hrsh7th/cmp-cmdline')
    call dein#add('nvim-treesitter/nvim-treesitter')
    call dein#add('jose-elias-alvarez/nvim-lsp-ts-utils')
    call dein#add('nvim-telescope/telescope.nvim')
    call dein#add('nvim-telescope/telescope-frecency.nvim')
    call dein#add('jose-elias-alvarez/null-ls.nvim')
  endif

  " Required:
  call dein#update()
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

lua require('lsp')
lua require('telescope-config')

" ================ Syntax and Colors =================
"turn on syntax highlighting
syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme gruvbox
set synmaxcol=500
set nocursorline
" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Turn Off Swap Files ===============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ===================
" Keep undo history across sessions, by storing in file.
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" ================ Indentation ======================
filetype indent on
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" ================ Folds =============================
set foldmethod=indent   "fold based on indent
set foldnestmax=4       "deepest fold is 4 levels
set nofoldenable        "dont fold by default

" ================ Completion ========================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=log/**
set wildignore+=tmp/**

" ================ Search ============================
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ============== Key Bindings ========================
" vim-test
let g:test#javascript#runner = 'jest'
let g:root_markers = ['package.json', '.git/']
function! s:RunVimTest(cmd)
    " I guess this part could be replaced by projectionist#project_root
    for marker in g:root_markers
        let marker_file = findfile(marker, expand('%:p:h') . ';')
        if strlen(marker_file) > 0
            let g:test#project_root = fnamemodify(marker_file, ":p:h")
            break
        endif
        let marker_dir = finddir(marker, expand('%:p:h') . ';')
        if strlen(marker_dir) > 0
            let g:test#project_root = fnamemodify(marker_dir, ":p:h")
            break
        endif
    endfor

    execute a:cmd
endfunction
nnoremap <leader>tn :call <SID>RunVimTest('TestNearest')<CR>
nnoremap <leader>tf :call <SID>RunVimTest('TestFile')<CR>
" buffer next/previous with leader
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>
" Fugitive Git Bindings
nnoremap <leader>fb :Git blame<CR>
nnoremap <leader>fo :GBrowse<CR>
" Open the project tree and expose current file in the nerdtree with Leader+fe
nnoremap <silent> <leader>fe :NERDTreeFind<CR>:vertical<CR>
"quickfix window navigation
nnoremap <leader>j :cnext<CR>
nnoremap <leader>k :cprev<CR>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" leader+gr to run GoldenRatio
nnoremap <leader>gr :GoldenRatioToggle<CR>
"(v)im (r)eload
nmap <silent> vr :so %<CR>
" Create vertical window splits easier. 
nnoremap <silent> vv <C-w>v
" w!! to write a file as sudo
cmap w!! w !sudo tee % >/dev/null
" leader+z to toggle folds
nnoremap <leader>z za
" Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>
" MRU
nnoremap <leader>mr :MRU<CR>

" Move between vim split windows by using the arrow keys
nnoremap <silent> <Left> <C-w>h
nnoremap <silent> <Right> <C-w>l
nnoremap <silent> <Up> <C-w>k
nnoremap <silent> <Down> <C-w>j
" ================ Experiments =======================
