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

" Set a few options which are the default in neovim
if !has("nvim")
    set encoding=utf-8
    set nobackup " don't keep backups
    set undodir=~/.cache/
    set autoread " automatically read externally modified files

    set incsearch " show matches while typing
    "set hlsearch " don't highlight search matches

    set autoindent " keep indent when starting a new line
    set wrap " wrap long lines

    set history=1024
endif

" Colors, Hidden Characters
colorscheme velvetopia " <3
set list
set listchars=tab:›\ ,trail:·,extends:❭,precedes:❬
au InsertEnter * :set listchars-=trail:·
au InsertLeave * :set listchars+=trail:·
set showbreak=↳ " display dots in front of wrapped lines

" Backup, Undo, Swap
set noswapfile
set undofile

" Search
set ignorecase " ignore case in search patterns
set smartcase " ... unless pattern contains upper case charecters
set nohlsearch

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
set tabpagemax=99999 " don't limit the number of tabs created by the -p switch
set visualbell " flash instead of beeping
let mapleader="," " Use , instead of \ as <Leader>
set notimeout " don't timeout on mappings
set shell=/bin/sh
set clipboard=unnamed,unnamedplus " use * and + in yank/paste operations
set lazyredraw " redraw only when we need to

" Spell Checking
set dictionary+=/usr/share/dict/american-english,/usr/share/dict/german

" Folding
set foldtext=getline(v:foldstart)
set fillchars=fold:\ 
highlight Folded ctermbg=DarkBlue ctermfg=None

" Mappings

" turn off search highlight
nnoremap <leader><Space> :nohlsearch<CR>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

nnoremap <Space> za

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" :%% expands to path of current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" <F5> to save all files and run make
map <F5> :wall!<CR>:make!<CR>

" gf to open the file in a new tab
nnoremap gf <C-W>gf

" <Leader>-/= to underline the current line with -'s or ='s
nmap <Leader>- yyp:s/./-/g<CR>
nmap <Leader>= yyp:s/./=/g<CR>

nmap <Backspace> hx

map <Leader>, :call Zoomout()<CR><CR>
map <Leader>. :!fontsize<CR><CR>

function! Zoomout()
    let deffontsize=18
    let rows=winheight(0)
    let lines=line('$')
    let newfontsize=deffontsize*rows/lines
    if newfontsize > deffontsize
        let newfontsize=deffontsize
    endif
    if newfontsize < 1
        let newfontsize=1
    endif
    execute '!fontsize ' . newfontsize
    normal zb
endfunction

" Autocommands

" When opening a file, always jump to the last known cursor position
autocmd bufreadpost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   execute 'normal! g`"zv' |
\   let b:doopenfold = 1 |
\ endif

" nnoremap p p=`]

" Resize splits when the window is resized
au Vimresized * :wincmd =

" Location of my private wiki
au BufRead,BufNewFile ~/permanent/wiki/* set ft=vimboy

" Highlight second-level markdown headings properly
syn match Special '---[-]*'
