lua << EOF
vim.g.mapleader = "," -- Use comma as a <Leader>.
EOF

packadd minpac
call minpac#init()

" Have minpac manage itself
call minpac#add('k-takata/minpac', {'type': 'opt'})
    command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
    command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" LSP quickstart.
call minpac#add('neovim/nvim-lspconfig')
lua << EOF
  local custom_lsp_attach = function(client)
    -- See `:help nvim_buf_set_keymap()` for more information
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})

    -- Use LSP as the handler for omnifunc.
    --    See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- For plugins with an `on_attach` callback, call them here. For example:
    -- require('completion').on_attach()
  end

  require('lspconfig').solargraph.setup{
    on_attach = custom_lsp_attach
  }
  require('lspconfig').sumneko_lua.setup{
  cmd = {"lua-language-server"}
  }
  custom_lsp_attach()
EOF

" Fix colorschemes.
call minpac#add('folke/lsp-colors.nvim')

call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
call minpac#add('nvim-treesitter/nvim-treesitter-textobjects')
call minpac#add('nvim-treesitter/playground')
lua << EOF
  local ts = require 'nvim-treesitter.configs'
  ts.setup {
    ensure_installed = 'maintained',
    highlight = {
      enable = true
    },
    textobjects = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
    },
  }
EOF

" Git stuff!
call minpac#add('tpope/vim-fugitive')

" Edit parens, brackets, and more.
call minpac#add('tpope/vim-surround')

" Repeat support for surround and other plugins.
call minpac#add('tpope/vim-repeat')

" Comment stuff out using 'gc'.
call minpac#add('tpope/vim-commentary')

" Pairs of handy bracket mappings.
call minpac#add('tpope/vim-unimpaired')

" Fuzzy-find everything!
call minpac#add('junegunn/fzf.vim')
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
call minpac#add('dhruvasagar/vim-table-mode')

" cx for exchange operations.
call minpac#add('tommcdo/vim-exchange')

" 'e' text object is the entire file.
call minpac#add('kana/vim-textobj-entire')
" Needed for vim-textobj-entire.
call minpac#add('kana/vim-textobj-user')

" Snippets, duh!
call minpac#add('SirVer/ultisnips')
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips"]

" In Ruby, insert 'end' statements automatically.
call minpac#add('tpope/vim-endwise')

" Dead simple personal wiki plugin.
call minpac#add('blinry/vimboy')

" Asynchronous code linting and fixing
call minpac#add('w0rp/ale')
    let g:ale_linters = {
    \    'rust': ['cargo'],
    \    'glsl': ['glslang']
    \}
    let g:ale_fixers = {
    \   'c': ['clang-format'],
    \   'arduino': ['clang-format'],
    \   'glsl': ['clang-format'],
    \   'css': ['prettier'],
    \   'haskell': ['hindent'],
    \   'html': ['prettier'],
    \   'json': ['prettier'],
    \   'javascript': ['prettier'],
    \   'vue': ['prettier']
    \}
    "\   'svelte': ['prettier'],
    "\   'ruby': ['rufo'],
    "\   'python': ['black'],

    "let g:ale_linters_aliases = {
    "\}
    let g:ale_linters_explicit = 1
    let g:ale_fix_on_save = 1
    " Mappings in the style of unimpaired-next
    nmap <silent> [W <Plug>(ale_first)
    nmap <silent> [w <Plug>(ale_previous)
    nmap <silent> ]w <Plug>(ale_next)
    nmap <silent> ]W <Plug>(ale_last)

" Asynchronous builds
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')

" Observe EditorConfig coding style settings.
call minpac#add('editorconfig/editorconfig-vim')

" Additional text objects.
call minpac#add('wellle/targets.vim')

" Better support for various filetypes.
call minpac#add('slim-template/vim-slim')
call minpac#add('tikhomirov/vim-glsl')
call minpac#add('rust-lang/rust.vim')
call minpac#add('matze/vim-lilypond')
call minpac#add('philj56/vim-asm-indent')
call minpac#add('mxw/vim-jsx')
call minpac#add('itchyny/vim-haskell-indent')
call minpac#add('neovimhaskell/haskell-vim')
    "let g:haskell_classic_highlighting=1
call minpac#add('calviken/vim-gdscript3')
call minpac#add('dag/vim-fish')
call minpac#add('907th/vim-auto-save')
"au! bufnewfile,bufread *.svelte set ft=html

"call minpac#add('floobits/floobits-neovim')
call minpac#add('jbyuki/instant.nvim')
let g:instant_username = "blinry"

" Colors, hidden Characters.
colorscheme default
set termguicolors " Use 'gui' highlight attributes instead of cterm.
set list " Show whitespace characters...
set listchars=tab:›\ ,trail:·,extends:❭,precedes:❬ " ... like this!
au InsertLeave * :set listchars+=trail:· " Show trailing whitespace in all modes...
au InsertEnter * :set listchars-=trail:· " ... except in insert mode.
set showbreak=↳ " Display this character in front of wrapped lines.

" Backup, undo, swap.
set noswapfile " Don't keep swap files.
set undofile " Keep undo files.
set backupcopy=yes " When saving, make a copy, then overwrite the original file.
                   " This is required for parcel's Hot Module Reload.
let g:netrw_dirhistmax = 0 " Don't write a .netrwhist file.

" Search.
set ignorecase " Ignore case in search patterns...
set smartcase " ... unless pattern contains upper case charecters.
set nohlsearch " Don't highlight other search matches.
set inccommand=nosplit " Show preview of substitutions while typing.

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
set nostartofline " Keep cursor in the same column for many commands.
set shell=/bin/bash
set clipboard=unnamed,unnamedplus " Use * and + in yank/paste operations.
set lazyredraw " Redraw only when we need to.
set splitright " Open vertical splits on the right side.
set splitbelow " Open horizontal splits on the bottom

" Working with buffers.
set hidden

" Spell checking.
set dictionary+=/usr/share/dict/american-english,/usr/share/dict/german

" MAPPINGS

map <F5> :wall!<CR>:Make<CR>

" Expand %% to the directory of the curent file.
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

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

" Mark bulleted item as done
nmap + :s/^\s*\zs[-x~?]/+<CR>:w<CR>

" Save and restore sessions.
let s:sessions_dir = '~/.local/share/nvim/sessions/'
exec 'nnoremap <Leader>ss :mks! ' . s:sessions_dir
exec 'nnoremap <Leader>sr :so ' . s:sessions_dir

" Edit snippets.
nmap <Leader>s :UltiSnipsEdit<CR>

" Show the highlight group the cursor is on.
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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

" Location of the Prototype Fund wiki.
au BufRead,BufNewFile ~/permanent/pf2-wiki/* set ft=vimboy

" Highlight second-level markdown headings properly.
syn match Special '---[-]*'

" Don't create temporary files of gopass secrets.
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

" Source Vim configuration upon save.
" au BufWritePost $MYVIMRC source %
