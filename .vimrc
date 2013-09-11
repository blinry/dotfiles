" initialize Vundle:
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-endwise'
Bundle 'blinry/vimboy'
let g:vimboy_autolink = 1
Bundle 'blinry/vimgirl'
Bundle 'tpope/vim-commentary'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-entire'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-markdown'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['java', 'tex'] }
Bundle 'Rip-Rip/clang_complete'
Bundle 'vim-scripts/matchit.zip'
let g:clang_auto_select = 1
let g:clang_complete_auto = 1
let g:clang_hl_errors = 1
let g:clang_close_preview = 1
let g:clang_user_options = '|| exit 0'
let g:clang_use_library = 1
let g:clang_complete_macros = 0
Bundle 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

filetype plugin indent on " activate filetype detection
syntax on " enable syntax highlighting


" Colors, Hidden Characters
colorscheme elflord " <3
set t_Co=256
set list
set listchars=tab:›\ ,trail:·,extends:❭,precedes:❬
au InsertEnter * :set listchars-=trail:·
au InsertLeave * :set listchars+=trail:·
set showbreak=↳ " display dots in front of wrapped lines

" Backup, Undo, Swap
set noswapfile
set nobackup " don't keep backups
set undofile
set undodir=~/.cache/
set viminfo+=n~/.cache/viminfo
set autoread " automatically read externally modified files

" Search
set ignorecase " ignore case in search patterns
set smartcase " ... unless pattern contains upper case charecters
set incsearch " show matches while typing

" Indentation, Linebreak
set autoindent " keep indent when starting a new line
set tabstop=4 " a <Tab> is 4 characters long
set softtabstop=4 " when editing indentations, edit 4 characters at once
set shiftwidth=4 " use 4 spaces when (auto)indenting
set expandtab " on a <Tab>, insert spaces
set colorcolumn=+1 " draw a line after 'textwidth'
set linebreak " display line breaks at reasonable places

" Status Line
set laststatus=2 " display status line for every window
set showcmd " show command as typing and area in visual mode
set noshowmode " don't show mode in last line, the powerline plugin already does this

" History, Command mode
set history=1024
set wildmode=longest:list,full " tab-complete to longest common match, then show all matches

" User Interface
set mouse=a " enable mouse use in all modes
set tabpagemax=99999 " don't limit the number of tabs created by the -p switch
set visualbell " flash instead of beeping
let mapleader="," " Use , instead of \ as <Leader>
set notimeout " don't timeout on mappings
set shell=/bin/sh

" Spell Checking
set dictionary+=/usr/share/dict/american-english,/usr/share/dict/german

" Folding
set foldtext=getline(v:foldstart)
set fillchars=fold:\ 

" Mappings

" <Space> to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" <C-p>/<C-n> for <Up>/<Down>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" :%% expands to path of current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" <F5> to save all files and run ":!make"
map <F5> :wall!<CR>:!make<CR>
map! <F5> <Esc>:wall!<CR>:!make<CR>a

" gf to open the file in a new tab
nnoremap gf <C-W>gf 

" <Leader>-/= to underline the current line with -'s or ='s
nmap <Leader>- yyp:s/./-/g<CR>
nmap <Leader>= yyp:s/./=/g<CR>

map <Leader>, :call Zoomout()<CR><CR>
map <Leader>. :!fontsize<CR><CR>

function Zoomout()
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

" n/N center around the cursor
nnoremap n nzzzv
nnoremap N Nzzzv

" Autocommands

" When opening a file, always jump to the last known cursor position
autocmd bufreadpost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   execute 'normal! g`"zvzz' |
\   let b:doopenfold = 1 |
\ endif

" Resize splits when the window is resized
au Vimresized * :wincmd =

if filereadable($HOME."/.vimrc.local")
    source $HOME/.vimrc.local
endif

