set nocompatible " be improved!

" initialize Vundle:
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" load bundles:
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-endwise'
Bundle 'Rip-Rip/clang_complete'
Bundle 'SirVer/ultisnips'
Bundle 'blinry/vimboy'
Bundle 'blinry/vimgirl'

filetype plugin indent on " activate filetype detection
syntax on " enable syntax highlighting
colorscheme elflord " <3
set t_Co=256

set nobackup " don't keep backups

" search settings:
set ignorecase " ignore case in search patterns
set smartcase " ... unless pattern contains upper case charecters
set incsearch " show matches while typing

set linebreak " display line breaks at reasonable places
set laststatus=2 " display status line for every window
set mouse=a " enable mouse use in all modes
set showbreak=… " display dots in front of wrapped lines
set showcmd " show command as typing and area in visual mode
set noshowmode " don't show mode in last line, the powerline plugin already does this
set tabpagemax=99999 " don't limit the number of tabs created by the -p switch
set viminfo+=n~/.cache/viminfo " save viminfo file in ~/.cache/
set wildmenu " enhanced command-line completion

" indentation
set autoindent " keep indent when starting a new line
set tabstop=4 " a <Tab> is 4 characters long
set softtabstop=4 " when editing indentations, edit 4 characters at once
set shiftwidth=4 " use 4 spaces when (auto)indenting
set expandtab " on a <Tab>, insert spaces
set smartindent " do smart autoindenting for C-like languages

set visualbell " flash instead of beeping

let mapleader="," " Use , instead of \ as <Leader>

map <F5> <Esc>:wall!<CR>:!make<CR> " by default, <F5> saves all files and runs "make"
nnoremap gf <C-W>gf " make gf open the file in a new tab
" underline the current line with -'s or ='s
nmap <Leader>- yyp:s/./-/g<CR>
nmap <Leader>= yyp:s/./=/g<CR>
nnoremap J mzJ`z " when joining lines, stay on the current character

" when opening a file, always jump to the last known cursor position.
autocmd bufreadpost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" settings for clang_complete:
let g:clang_auto_select = 1
let g:clang_complete_auto = 1
let g:clang_hl_errors = 1
let g:clang_close_preview = 1
let g:clang_user_options = '|| exit 0'
let g:clang_use_library = 1
let g:clang_complete_macros = 0

" settings for ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" include local version of this file, if it exists
if filereadable($HOME."/.vimrc.local")
    source $HOME/.vimrc.local
endif
