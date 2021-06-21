let mapleader="," " Use comma as a <Leader>.
let maplocalleader="," " Also use comma as a <Localleader> (for vim-tidal).

" Automatically install plug.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize plug.
call plug#begin()

" Git stuff!
Plug 'tpope/vim-fugitive'

" Edit parens, brackets, and more.
Plug 'tpope/vim-surround'

" Repeat support for surround and other plugins.
Plug 'tpope/vim-repeat'

" Comment stuff out using 'gc'.
Plug 'tpope/vim-commentary'

" Pairs of handy bracket mappings.
Plug 'tpope/vim-unimpaired'

" Fuzzy-find everything!
Plug 'junegunn/fzf.vim'
    nnoremap ; :Buffers<CR>
    nnoremap <C-p> :Files<CR>

    nnoremap <Leader>f :GFiles<CR>
    nnoremap <Leader>h :History<CR>
    nnoremap <Leader>l :BLines<CR>
    nnoremap <Leader>L :Lines<CR>
    nnoremap <Leader>g :Rg<CR>
    nnoremap <Leader>H :Helptags!<CR>
    nnoremap <Leader>: :History:<CR>
    nnoremap <Leader>/ :History/<CR>
    "nnoremap <C-r> :Rg<CR>
    "cabbrev tabe Files<CR>

" Format tables and calculate stuff in them.
Plug 'dhruvasagar/vim-table-mode'

" cx for exchange operations.
Plug 'tommcdo/vim-exchange'

" 'e' text object is the entire file.
Plug 'kana/vim-textobj-entire'
" Needed for vim-textobj-entire.
Plug 'kana/vim-textobj-user'

" Snippets, duh!
"Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips"]

" In Ruby, insert 'end' statements automatically.
Plug 'tpope/vim-endwise'

" Dead simple personal wiki plugin.
Plug 'blinry/vimboy'

" Asynchronous code linting and fixing
Plug 'w0rp/ale'
    let g:ale_fixers = {
    \   'c': ['clang-format'],
    \   'python': ['black'],
    \   'html': ['prettier'],
    \   'javascript': ['prettier'],
    \   'css': ['prettier'],
    \}
    let g:ale_linters_explicit = 1
    let g:ale_fix_on_save = 1

" Better support for various filetypes.
Plug 'slim-template/vim-slim'
Plug 'tikhomirov/vim-glsl'
Plug 'rust-lang/rust.vim'
Plug 'matze/vim-lilypond'
Plug 'philj56/vim-asm-indent'
"Plug 'rhysd/vim-wasm'
"Plug 'sheerun/vim-polyglot'
Plug 'https://gitlab.com/n9n/vim-apl'
Plug 'mxw/vim-jsx'

"Plug 'airblade/vim-gitgutter'
"    let g:gitgutter_sign_added = '+'
"    let g:gitgutter_sign_modified = '>'
"    let g:gitgutter_sign_removed = '-'
"    let g:gitgutter_sign_removed_first_line = '^'
"    let g:gitgutter_sign_modified_removed = '<'
"    let g:gitgutter_override_sign_column_highlight = 1
"    "highlight SignColumn guibg=bg
"    "highlight SignColumn ctermbg=bg
"    set updatetime=250

Plug 'tidalcycles/vim-tidal'
    let g:tidal_target="terminal"

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
set notimeout " Don't timeout on mappings.
set shell=/bin/bash
set clipboard=unnamed,unnamedplus " Use * and + in yank/paste operations.
set lazyredraw " Redraw only when we need to.

" Working with buffers.
set hidden

" Spell checking.
set dictionary+=/usr/share/dict/american-english,/usr/share/dict/german

" MAPPINGS

" Bubble lines
nmap <C-k> [e
nmap <C-j> ]e
vmap <C-k> [egv
vmap <C-j> ]egv

" Toggle search highlight.
nnoremap <Leader><Space> :set hlsearch!<CR>

" Add more undo-steps when writing prose.
inoremap . .<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u
inoremap , ,<C-g>u

" Underline the current line with - or =.
nmap <Leader>- "ayy"ap:s/./-/g<CR>
nmap <Leader>= "ayy"ap:s/./=/g<CR>

" Edit snippets.
nmap <Leader>s :UltiSnipsEdit<CR>

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
