" Initialize the Minimalist Vim Plugin Manager
call plug#begin()

" Browse folders with -
Plug 'tpope/vim-vinegar'
" open files *fast*!
Plug 'ctrlpvim/ctrlp.vim'
" Format tables and calculate stuff in them
Plug 'dhruvasagar/vim-table-mode'
" cx for exchange operation
Plug 'tommcdo/vim-exchange'
" 'e' text object is the entire file
Plug 'kana/vim-textobj-entire'
" needed for vim-textobj-entire
Plug 'kana/vim-textobj-user'
" snippets, duh!
Plug 'SirVer/ultisnips'
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" in Ruby, insert 'end' statements automatically
Plug 'tpope/vim-endwise'
" Enhance % for various languages
Plug 'vim-scripts/matchit.zip'
" Syntax checking
Plug 'vim-syntastic/syntastic'
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
" dead simple personal wiki plugin
Plug 'blinry/vimboy'
" Support for slim
Plug 'slim-template/vim-slim'
" Support for GLSL
Plug 'tikhomirov/vim-glsl'
" Support for Rust
Plug 'rust-lang/rust.vim'
call plug#end()

filetype plugin indent on " activate filetype detection
syntax on " enable syntax highlighting

" Set a few options which have reasonable defaults in Neovim
if !has("nvim")
    set encoding=utf-8 " well, come on
    set nobackup " don't keep backups
    set undodir=~/.cache/ " put undo files here
    set autoread " automatically read externally modified files

    set incsearch " show matches while typing

    set autoindent " keep indent when starting a new line
    set wrap " wrap long lines

    set history=10000 " remember this many commands
endif

" Colors, Hidden Characters
colorscheme velvetopia " my own li'l colorscheme <3
set list " show whitespace characters
set listchars=tab:›\ ,trail:·,extends:❭,precedes:❬ " ... like this!
au InsertLeave * :set listchars+=trail:· " show trailing whitespace in all modes
au InsertEnter * :set listchars-=trail:· " ... except insert mode
set showbreak=↳ " display this character in front of wrapped lines

" Backup, Undo, Swap
set noswapfile " don't keep swap files
set undofile " keep undo files

" Search
set ignorecase " ignore case in search patterns
set smartcase " ... unless pattern contains upper case charecters
set nohlsearch " don't highlight other searh matches

" Editing
set nojoinspaces " when joining lines, don't insert two spaces after punctuation

" Indentation, Linebreak
set tabstop=4 " a <Tab> is 4 characters long
set softtabstop=4 " when editing indentations, edit 4 characters at once
set shiftwidth=4 " use 4 spaces when (auto)indenting
set expandtab " on a <Tab>, insert spaces
set colorcolumn=+1 " draw a line after 'textwidth'
set breakindent " keep indentation when wrapping lines

" Status Line
set showcmd " show command as typing and area in visual mode

" History, Command mode
set wildmode=longest:list,full " tab-complete to longest common match, then show all matches

" User Interface
set mouse=a " enable mouse use in all modes
set completeopt=menu,menuone,longest
set tabpagemax=10000 " don't limit the number of tabs created by the -p switch
set visualbell " flash instead of beeping
let mapleader="," " Use , instead of \ as <Leader>
set notimeout " don't timeout on mappings
set shell=/bin/sh
set clipboard=unnamed,unnamedplus " use * and + in yank/paste operations
set lazyredraw " redraw only when we need to

" Spell Checking
set dictionary+=/usr/share/dict/american-english,/usr/share/dict/german

" MAPPINGS

" toggle search highlight
nnoremap <leader><Space> :set hlsearch!<CR>

" scroll through command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" :%% expands to path of current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" gf to open the file in a new tab
nnoremap gf <C-W>gf

" add more undo-steps when writing prose
inoremap . .<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u
inoremap , ,<C-g>u

" <Leader>-/= to underline the current line with -'s or ='s
nmap <Leader>- yyp:s/./-/g<CR>
nmap <Leader>= yyp:s/./=/g<CR>

" AUTOCOMMANDS

" when opening a file, always jump to the last known cursor position
autocmd bufreadpost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   execute 'normal! g`"zv' |
\   let b:doopenfold = 1 |
\ endif

" auto-indent pasted text
nnoremap p p=`]

" resize splits when the window is resized
au Vimresized * :wincmd =

" location of my private wiki
au BufRead,BufNewFile ~/permanent/wiki/* set ft=vimboy

" location of the PF wiki
au BufRead,BufNewFile ~/permanent/pf-wiki/* set ft=vimboy

" highlight second-level markdown headings properly
syn match Special '---[-]*'
