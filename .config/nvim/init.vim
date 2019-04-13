" Initialize plug.
call plug#begin()

" Edit parens, brackets, and more.
Plug 'tpope/vim-surround'

" Repeat support for surround and other plugins.
Plug 'tpope/vim-repeat'

" Fuzzy-find everything!
Plug 'junegunn/fzf.vim'
    nnoremap <C-p> :Files<CR>
    nnoremap <C-g> :Rg<CR>
    nnoremap ; :Buffers<CR>

" Format tables and calculate stuff in them.
Plug 'dhruvasagar/vim-table-mode'

" cx for exchange operations.
Plug 'tommcdo/vim-exchange'

" 'e' text object is the entire file.
Plug 'kana/vim-textobj-entire'
" Needed for vim-textobj-entire.
Plug 'kana/vim-textobj-user'

" Snippets, duh!
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" In Ruby, insert 'end' statements automatically.
Plug 'tpope/vim-endwise'

" Dead simple personal wiki plugin.
Plug 'blinry/vimboy'

" Better support for various filetypes.
Plug 'slim-template/vim-slim'
Plug 'tikhomirov/vim-glsl'
Plug 'rust-lang/rust.vim'
Plug 'matze/vim-lilypond'
Plug 'philj56/vim-asm-indent'

call plug#end()

" Colors, hidden Characters.
colorscheme velvetopia " My own li'l colorscheme. <3
set list " Show whitespace characters...
set listchars=tab:›\ ,trail:·,extends:❭,precedes:❬ " ... like this!
au InsertLeave * :set listchars+=trail:· " Show trailing whitespace in all modes...
au InsertEnter * :set listchars-=trail:· " ... except in insert mode.
set showbreak=↳ " Display this character in front of wrapped lines.

" Backup, undo, swap.
set noswapfile " Don't keep swap files.
set undofile " Keep undo files.
let g:netrw_dirhistmax = 0 " Don't write a .netrwhist file.

" Search.
set ignorecase " Ignore case in search patterns...
set smartcase " ... unless pattern contains upper case charecters.
set nohlsearch " Don't highlight other search matches.

" Editing.
set nojoinspaces " When joining lines, don't insert two spaces after punctuation.

" Indentation, line break.
set tabstop=4 " A <Tab> is 4 characters long.
set softtabstop=4 " When editing indentations, edit 4 characters at once.
set shiftwidth=4 " Use 4 spaces when (auto)indenting.
set expandtab " On a <Tab>, insert spaces.
set colorcolumn=+1 " Draw a line after 'textwidth'.
set breakindent " Keep indentation when wrapping lines.

" History, command mode.
set wildignorecase
set wildmode=longest:list,full " Tab-complete to longest common match, then show all matches.

" User interface.
set mouse=a " Enable mouse use in all modes.
let mapleader="\<Space>" " Use space as a <Leader>.
set notimeout " Don't timeout on mappings.
set shell=/bin/sh
set clipboard=unnamed,unnamedplus " Use * and + in yank/paste operations.
set lazyredraw " Redraw only when we need to.

" Working with buffers.
set hidden

" Spell checking.
set dictionary+=/usr/share/dict/american-english,/usr/share/dict/german

" MAPPINGS

" Navigate windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle search highlight.
nnoremap <Leader><Space> :set hlsearch!<CR>

" Add more undo-steps when writing prose.
inoremap . .<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u
inoremap , ,<C-g>u

" Underline the current line with - or =.
nmap <Leader>- yyp:s/./-/g<CR>
nmap <Leader>= yyp:s/./=/g<CR>

" AUTOCOMMANDS

" When opening a file, always jump to the last known cursor position.
autocmd bufreadpost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   execute 'normal! g`"zv' |
\   let b:doopenfold = 1 |
\ endif

" Resize splits when the window is resized.
au Vimresized * :wincmd =

" Location of my private wiki.
au BufRead,BufNewFile ~/permanent/wiki/* set ft=vimboy

" Highlight second-level markdown headings properly.
syn match Special '---[-]*'

" Don't create temporary files of gopass secrets.
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

" Source Vim configuration upon save.
au BufWritePost $MYVIMRC source %
