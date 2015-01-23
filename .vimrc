" initialize Vundle:
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'derekwyatt/vim-scala'
Bundle 'dhruvasagar/vim-table-mode'
Bundle 'tommcdo/vim-exchange'
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
" Very smart autocompletion
Bundle 'Valloric/YouCompleteMe'
    let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']
    let g:ycm_key_list_select_completion = ['<C-n>']
    let g:ycm_key_list_previous_completion = ['<C-p>']
    let g:ycm_filetype_blacklist = {'qf':1, 'markdown':1, 'vimboy':1,
                                  \ 'mail':1, 'text':1, 'tex':1, 'plaintex':1}
" For compability between YCM and UltiSnips
Bundle 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = '<C-n>'

filetype plugin indent on " activate filetype detection
syntax on " enable syntax highlighting

" Colors, Hidden Characters
colorscheme velvetopia
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

" Editing
set nojoinspaces " when joining lines, don't insert two spaces after punctuation

" Indentation, Linebreak
set autoindent " keep indent when starting a new line
set tabstop=4 " a <Tab> is 4 characters long
set softtabstop=4 " when editing indentations, edit 4 characters at once
set shiftwidth=4 " use 4 spaces when (auto)indenting
set expandtab " on a <Tab>, insert spaces
set colorcolumn=+1 " draw a line after 'textwidth'
set wrap " wrap long lines

" Status Line
set showcmd " show command as typing and area in visual mode

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
highlight Folded ctermbg=DarkBlue ctermfg=None

" Mappings

nnoremap <Space> za

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" :%% expands to path of current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" <F5> to save all files and run make
map <F5> :wall!<CR>:make<CR>

" gf to open the file in a new tab
nnoremap gf <C-W>gf

" <Leader>-/= to underline the current line with -'s or ='s
nmap <Leader>- yyp:s/./-/g<CR>
nmap <Leader>= yyp:s/./=/g<CR>

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

nnoremap p p=`]

" Resize splits when the window is resized
au Vimresized * :wincmd =

if filereadable($HOME."/.vimrc.local")
    source $HOME/.vimrc.local
endif
