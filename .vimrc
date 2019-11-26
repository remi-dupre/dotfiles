"
"   __ _  ___ _ __   ___ _ __ __ _| |
"  / _` |/ _ \ '_ \ / _ \ '__/ _` | |
" | (_| |  __/ | | |  __/ | | (_| | |
"  \__, |\___|_| |_|\___|_|  \__,_|_|
"  |___/
"


let mapleader = ","

if has("gui_running")
    colorscheme atom-dark
else
    colorscheme atom-dark-256
endif

set t_ut=

syntax on
filetype plugin indent on

set number relativenumber
set signcolumn=yes
set autoindent
set cursorline
set ruler
set linebreak
set breakindent
set breakindentopt=shift:1
set colorcolumn=80
set list listchars=trail:·,tab:»\ "
set encoding=utf-8
set cmdheight=2 " better display for messages
set nobackup " some CoC servers have issues with backup files, see #649
set nowritebackup
set hidden

set expandtab
set backspace=2
set softtabstop=4
set tabstop=4
set shiftwidth=4

set smartcase
set incsearch
set hlsearch

set updatetime=300

set mouse=a

if has('nvim')
else
    set ttymouse=sgr
    set balloondelay=250
    set ballooneval
    set balloonevalterm
    set renderoptions=type:directx
endif

" Clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" set guifont=Hasklig\ Regular\ 8
" set guioptions -=m
" set guioptions -=T
" set guioptions -=r

map <C-j> :lnext<return>
map <C-k> :lprev<return>


"        _             _
"  _ __ | |_   _  __ _(_)_ __  ___
" | '_ \| | | | |/ _` | | '_ \/ __|
" | |_) | | |_| | (_| | | | | \__ \
" | .__/|_|\__,_|\__, |_|_| |_|___/
" |_|            |___/

call plug#begin('~/.vim/plugged')
    " Vim syntax for TOML
    Plug 'cespare/vim-toml'

    " Vim plugin, insert or delete brackets, parens, quotes in pair
    " Plug 'jiangmiao/auto-pairs'

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

    " Vim match-up: even better %, modern matchit and matchparen replacement
    Plug 'andymass/vim-matchup'

    " Adds file type icons to Vim plugins
    " NOTE: Requires a patched font: https://github.com/ryanoasis/nerd-fonts/
    Plug 'ryanoasis/vim-devicons'

    Plug 'itchyny/lightline.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" Lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \   },
      \   'component_function': {
      \     'cocstatus': 'coc#status',
      \     'currentfunction': 'CocCurrentFunction'
      \   },
      \ }

let g:lightline#bufferline#enable_devicons = 1

" let g:lightline.component_expand = {
"     \  'linter_checking': 'lightline#ale#checking',
"     \  'linter_warnings': 'lightline#ale#warnings',
"     \  'linter_errors': 'lightline#ale#errors',
"     \  'linter_ok': 'lightline#ale#ok',
"     \ }
" let g:lightline.component_type = {
"     \     'linter_checking': 'left',
"     \     'linter_warnings': 'warning',
"     \     'linter_errors': 'error',
"     \     'linter_ok': 'left',
"     \ }
" let g:lightline.active = {
"     \     'right': [[
"     \         'linter_checking',
"     \         'linter_errors',
"     \         'linter_warnings',
"     \         'linter_ok'
"     \     ]]
"     \ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"

" Auto Pairs:
let g:AutoPairsMultilineClose = 0


" GitGutter:
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '┊'
let g:gitgutter_sign_removed = '␡'
let g:gitgutter_sign_removed_first_line = '␡'
let g:gitgutter_sign_modified_removed = '┊␡'


" Fzf:
map ; :Files<CR>


" NerdTree:
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


" Ale
let g:ale_completion_enabled = 1
let g:ale_set_balloons = 1

let g:ale_set_loclist = 1
let g:ale_fix_on_save = 0

let g:ale_linters = {
\   'rust': ['rls', 'rustfmt', 'cargo'],
\   'python': ['pylint'],
\}

" let g:ale_python_pylint_options = '--load-plugins pylint_django'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format'],
\   'rust': ['rustfmt'],
\   'python': ['black'],
\   'bib': ['bibclean'],
\}

"let g:ale_bib_bibclean_options = '-quiet'
let g:ale_rust_rustfmt_options = '+nightly'
let g:ale_rust_cargo_use_clippy = 1

" Lightline
set laststatus=2

" CoC
let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-rls',
    \ 'coc-python',
    \ 'coc-json'
  \ ]

nmap <silent> gd <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


"  _
" | | __ _ _ __   __ _ _   _  __ _  __ _  ___  ___
" | |/ _` | '_ \ / _` | | | |/ _` |/ _` |/ _ \/ __|
" | | (_| | | | | (_| | |_| | (_| | (_| |  __/\__ \
" |_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___||___/
"                |___/             |___/

autocmd FileType html set ts=2 sw=2 sts=2
autocmd FileType htmldjango set ts=2 sw=2 sts=2
autocmd FileType rust set cc=101

autocmd FileType rst set cc=73 tw=72
autocmd FileType yaml     set ts=2 sw=2 sts=2 tw=79

autocmd FileType tex      set ts=2 sw=2 sts=2 tw=79 spell spelllang=en
autocmd FileType plaintex set ts=2 sw=2 sts=2 tw=79 spell spelllang=en

"  _                      _
" | |___      _____  __ _| | _____
" | __\ \ /\ / / _ \/ _` | |/ / __|
" | |_ \ V  V /  __/ (_| |   <\__ \
"  \__| \_/\_/ \___|\__,_|_|\_\___/
"

" Cursor shape on xfce4-terminal
" if has("autocmd")
"     autocmd InsertEnter * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_IBEAM/' ~/.config/xfce4/terminal/terminalrc"
"     autocmd InsertLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
"     autocmd VimLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
" endif

autocmd User CocStatusChange,CocDiagnosticChange call strftime('%c')

function! Test()
    call coc#refresh()
    call lightline#update()
    echo strftime('%c')
endfunction
