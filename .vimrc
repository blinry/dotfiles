" initialize Vundle:
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" obligatory
Bundle 'gmarik/vundle'
" support for the 'nutsh' language
Bundle 'blinry/vim-nutsh'
" dead simple personal wiki plugin
Bundle 'blinry/vimboy'
    let g:vimboy_autolink = 1
" 'e' text object is the entire file
Bundle 'kana/vim-textobj-entire'
" needed for 'vim-textobj-entire'
Bundle 'kana/vim-textobj-user'
" open files *fast*!
Bundle 'kien/ctrlp.vim'
" :Ack function
Bundle 'mileszs/ack.vim'
" autocompletion for C/++ with clang
Bundle 'Rip-Rip/clang_complete'
    let g:clang_auto_select = 1
    let g:clang_close_preview = 1
    let g:clang_complete_auto = 1
    let g:clang_complete_macros = 0
    let g:clang_hl_errors = 1
    let g:clang_use_library = 1
    let g:clang_user_options = '|| exit 0'
" show errors in code upon write
Bundle 'scrooloose/syntastic'
    let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': [],
                               \ 'passive_filetypes': ['java', 'tex'] }
" snippets, duh!
Bundle 'SirVer/ultisnips'
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsSnippetDirectories=["ultisnips"]
" in Ruby, insert 'end' statements automatically
Bundle 'tpope/vim-endwise'
" improved markdown support
Bundle 'tpope/vim-markdown'
" Enhance % for various languages
Bundle 'vim-scripts/matchit.zip'
" Move visual selections around
Bundle 'shinokada/dragvisuals.vim'
    vmap <expr> H DVB_Drag('left')
    vmap <expr> L DVB_Drag('right')
    vmap <expr> J DVB_Drag('down')
    vmap <expr> K DVB_Drag('up')
    vmap <expr> P DVB_Duplicate()
    let g:DVB_TrimWS = 1 " remove trailing whitespace after moving...

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
"set noshowmode " don't show mode in last line, the powerline plugin already does this

" History, Command mode
set history=1024
set wildmode=longest:list,full " tab-complete to longest common match, then show all matches

" User Interface
set mouse=a " enable mouse use in all modes
set completeopt=menu,menuone,longest
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

