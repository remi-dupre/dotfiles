"
"   __ _  ___ _ __   ___ _ __ __ _| |
"  / _` |/ _ \ '_ \ / _ \ '__/ _` | |
" | (_| |  __/ | | |  __/ | | (_| | |
"  \__, |\___|_| |_|\___|_|  \__,_|_|
"  |___/
"

colorscheme seattle
set t_ut=

syntax on
filetype plugin indent on

set number relativenumber
set autoindent
set cursorline
set ruler
set linebreak
set breakindent
set breakindentopt=shift:1
set colorcolumn=80
set list listchars=trail:·,tab:»\

set expandtab
set backspace=2
set softtabstop=4
set tabstop=4
set shiftwidth=4

set smartcase
set incsearch
set hlsearch

set mouse=a
set updatetime=20

set guifont=Noto\ Sans\ Mono\ 8
set guioptions -=m
set guioptions -=T


"            _                               _
"   __ _  __| |_   ____ _ _ __   ___ ___  __| |
"  / _` |/ _` \ \ / / _` | '_ \ / __/ _ \/ _` |
" | (_| | (_| |\ V / (_| | | | | (_|  __/ (_| |
"  \__,_|\__,_| \_/ \__,_|_| |_|\___\___|\__,_|
"

set foldmethod=indent
set nofoldenable
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

"        _             _
"  _ __ | |_   _  __ _(_)_ __  ___
" | '_ \| | | | |/ _` | | '_ \/ __|
" | |_) | | |_| | (_| | | | | \__ \
" | .__/|_|\__,_|\__, |_|_| |_|___/
" |_|            |___/

call plug#begin('~/.vim/plugged')
    " Plug 'vim-syntastic/syntastic'
    Plug 'Valloric/YouCompleteMe'

    " Autocompletion
    Plug 'maralla/completor.vim'

    " Vim plugin, insert or delete brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'

    " A Vim plugin which shows a git diff in the gutter and stages/undoes hunks
    Plug 'airblade/vim-gitgutter'

    " Distraction-free writing in Vim 
    Plug 'junegunn/goyo.vim'

    " Quick file search
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

    " Quoting/parenthesizing made simple
    Plug 'tpope/vim-surround'

    " A tree explorer plugin for Vim
    Plug 'scrooloose/nerdtree'

    " Vim plugin for intensely orgasmic commenting 
    Plug 'scrooloose/nerdcommenter'

    " vim match-up: even better %, modern matchit and matchparen replacement
    Plug 'andymass/vim-matchup'

    " FIGlet plugin for vim
    Plug 'fadein/vim-FIGlet'
call plug#end()


" Completor:
let g:completor_clang_binary = '/usr/bin/clang'
let g:completor_python_binary = '/usr/bin/python'


" Auto Pairs:
" let g:AutoPairsFlyMode = 1


" GitGutter:
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

highlight GitGutterChange ctermfg=203 ctermbg=236


" Fzf:
map ; :Files<CR>


" Multiple Cursors:
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
    endif
endfunction

function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
    endif
endfunction


" NerdTree:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '🗀 '
let g:NERDTreeDirArrowCollapsible = '🗁 '
map <C-x> :NERDTreeToggle<CR>


" NerdCommenter:
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 0
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1


" Vim Matchup:
hi MatchWord ctermfg=lightgreen guifg=lightgreen cterm=bold gui=bold

"  _
" | | __ _ _ __   __ _ _   _  __ _  __ _  ___  ___
" | |/ _` | '_ \ / _` | | | |/ _` |/ _` |/ _ \/ __|
" | | (_| | | | | (_| | |_| | (_| | (_| |  __/\__ \
" |_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___||___/
"                |___/             |___/

autocmd FileType tex set ts=2 sw=2 sts=2 tw=79 expandtab
autocmd FileType html set ts=2 sw=2 sts=2 expandtab


"  _                      _
" | |___      _____  __ _| | _____
" | __\ \ /\ / / _ \/ _` | |/ / __|
" | |_ \ V  V /  __/ (_| |   <\__ \
"  \__| \_/\_/ \___|\__,_|_|\_\___/
"

" Cursor shape on xfce4-terminal
if has("autocmd")
  autocmd InsertEnter * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_IBEAM/' ~/.config/xfce4/terminal/terminalrc"
  autocmd InsertLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
  autocmd VimLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
endif

