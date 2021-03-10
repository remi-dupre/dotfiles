"
"   __ _  ___ _ __   ___ _ __ __ _| |
"  / _` |/ _ \ '_ \ / _ \ '__/ _` | |
" | (_| |  __/ | | |  __/ | | (_| | |
"  \__, |\___|_| |_|\___|_|  \__,_|_|
"  |___/
"
syntax on
filetype plugin indent on

let mapleader = ","
set t_ut=
set number relativenumber
set signcolumn=yes
set autoindent
set cursorline
set ruler
set linebreak
set breakindent
set breakindentopt=shift:1
set colorcolumn=80
set list listchars=trail:·,nbsp:␣,tab:»\ "
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
    set guifont=FiraMono\ Nerd\ Font\ 9
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
endif

" Clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)

"        _             _
"  _ __ | |_   _  __ _(_)_ __  ___
" | '_ \| | | | |/ _` | | '_ \/ __|
" | |_) | | |_| | (_| | | | | \__ \
" | .__/|_|\__,_|\__, |_|_| |_|___/
" |_|            |___/

call plug#begin('~/.vim/plugged')
    " Color scheme
    Plug 'jacoborus/tender.vim'

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

    " A light and configurable statusline/tabline plugin for Vim
    Plug 'itchyny/lightline.vim'

    " Intellisense engine for Vim8 & Neovim, full language server protocol
    " support as VSCode
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Highlight docstrings as comments
    Plug 'Kareeeeem/python-docstring-comments'

    " A vim plugin to display the indention levels with thin vertical lines
    Plug 'Yggdroot/indentLine'

    " Improved conceal for tex in vim
    Plug 'PietroPate/vim-tex-conceal'

    " Languages syntax
    Plug 'cespare/vim-toml'
    Plug 'pest-parser/pest.vim'
    Plug 'seirl/vim-jinja-languages'
    Plug 'vim-python/python-syntax'
call plug#end()


" Color scheme
set termguicolors
set background=dark
colorscheme tender

highlight LineNr        ctermbg=NONE guibg=NONE
highlight SignColumn    ctermbg=NONE guibg=NONE
highlight Normal        ctermbg=NONE guibg=NONE


" Lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! CocGitBlame()
    let blame = get(b:, 'coc_git_blame', '')
    return blame
endfunction

function! CocStatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, '🛑 ' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, '⚠ ' . info['warning'])
    endif
    return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

let g:lightline = {
 \  'colorscheme': 'tender',
 \  'active': {
 \      'left': [
 \          [ 'mode', 'paste' ],
 \          [ 'cocstatus', 'currentfunction'],
 \          [ 'readonly', 'filename', 'modified' ],
 \      ],
 \      'right': [
 \          [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
 \          [ 'blame' ],
 \      ]
 \  },
 \  'component_function': {
 \      'blame': 'CocGitBlame',
 \      'cocstatus': 'CocStatusDiagnostic',
 \      'currentfunction': 'CocCurrentFunction',
 \  }
 \}

let g:lightline#bufferline#enable_devicons = 1
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"


" Auto Pairs:
let g:AutoPairsMultilineClose = 2

function! CocGitBlame()
    let blame = get(b:, 'coc_git_blame', '')
    return blame
endfunction

function! CocStatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    let msgs = []

    if empty(info) | return '' | endif

    if get(info, 'error', 0)
        call add(msgs, ' ' . info['error'])
    endif

    if get(info, 'warning', 0)
        call add(msgs, '⚠ ' . info['warning'])
    endif

    return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! FileType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype  : 'no ft') : ''
endfunction


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


" Lightline:
set laststatus=2

" IndentLine:
let g:indentLine_char = '⁚'
let g:indentLine_setConceal = 2


" CoC:
let g:coc_global_extensions = [
 \  'coc-pairs',
 \  'coc-git',
 \  'coc-clangd',
 \  'coc-json',
 \  'coc-python',
 \  'coc-rust-analyzer'
 \]

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

nmap <C-h> <Plug>(coc-git-prevchunk)
nmap <C-l> <Plug>(coc-git-nextchunk)
nmap <silent> gu :CocCommand git.browserOpen<CR>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" coc-pairs:
autocmd FileType tex let b:coc_pairs = [["$", "$"]]

" vim-tex-conceal:
set conceallevel=2
let g:tex_conceal="abdgms"


"  _
" | | __ _ _ __   __ _ _   _  __ _  __ _  ___  ___
" | |/ _` | '_ \ / _` | | | |/ _` |/ _` |/ _ \/ __|
" | | (_| | | | | (_| | |_| | (_| | (_| |  __/\__ \
" |_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___||___/
"                |___/             |___/

autocmd FileType html       set ts=2 sw=2 sts=2
autocmd FileType htmldjango set ts=2 sw=2 sts=2
autocmd FileType rust       set cc=101

autocmd Filetype json       let g:indentLine_setConceal = 0
autocmd FileType json       set ts=4 sw=4 sts=4 tw=79
autocmd FileType python     set cc=100
autocmd FileType rst        set cc=73 tw=72
autocmd FileType yaml       set ts=2 sw=2 sts=2 tw=79

autocmd FileType tex        set ts=2 sw=2 sts=2 tw=79 spell spelllang=en
autocmd FileType plaintex   set ts=2 sw=2 sts=2 tw=79 spell spelllang=en

" Custom colors
hi CocRustChainingHint      ctermfg=Black guifg=Black
hi CocRustTypeHint          ctermfg=Black guifg=Black

" Fix python docstrings
syn region Comment start=/"""/ end=/"""/
syn region pythonDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=pythonEscape,@Spell,pythonDoctest,pythonDocTest2,pythonSpaceError

" Extra python highlighting
let g:python_highlight_all = 1

"  _                      _
" | |___      _____  __ _| | _____
" | __\ \ /\ / / _ \/ _` | |/ / __|
" | |_ \ V  V /  __/ (_| |   <\__ \
"  \__| \_/\_/ \___|\__,_|_|\_\___/
"
"

" Use external clipboard
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
" nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" Remove highlighting when entering insert mode
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>
