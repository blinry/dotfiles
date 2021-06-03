local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = "," -- Use comma as a <Leader>.

-- Initialize Paq, and let it manage itself.
vim.cmd('packadd paq-nvim')
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt=true}

-- LSP quickstart.
paq {'neovim/nvim-lspconfig'}
  local custom_lsp_attach = function()
        local opts = {}
        map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

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
    cmd = {"lua-language-server"},
    root_dir = require('lspconfig').util.root_pattern(".git", "init.lua"),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      }
    }
  }
  require"lspconfig".efm.setup {

  init_options = {documentFormatting = true},

  filetypes = {"lua"},

  settings = {

      rootMarkers = {".git", "init.lua"},

      languages = {

          lua = {

              {

                  formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",

                  formatStdin = true

              }

          }

      }

  }

}
  require('lspconfig').vimls.setup{}
  require('lspconfig').tsserver.setup{
      on_attach = custom_lsp_attach
  }
  require('lspconfig').html.setup{
      cmd = { "vscode-html-languageserver", "--stdio" }
  }

  vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

-- Fix colorschemes.
paq {'folke/lsp-colors.nvim'}

-- Completions
paq {'hrsh7th/nvim-compe'}
  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
      path = true;
      buffer = true;
      calc = true;
      nvim_lsp = true;
      nvim_lua = true;
      vsnip = true;
      ultisnips = true;
    };
  }
  map('i', '<silent><expr> <Tab>', "compe#complete()")
  map('i', '<silent><expr> <CR>',      "compe#confirm('<CR>')")
  map('i', '<silent><expr> <C-e>',     "compe#close('<C-e>')")
  map('i', '<silent><expr> <C-f>',     "compe#scroll({ 'delta': +4 })")
  map('i', '<silent><expr> <C-d>',     "compe#scroll({ 'delta': -4 })")

paq {'nvim-treesitter/nvim-treesitter', ['do']=':TSUpdate'}
paq {'nvim-treesitter/nvim-treesitter-textobjects'}
paq {'nvim-treesitter/playground'}
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

-- Git stuff!
paq {'tpope/vim-fugitive'}

-- Edit parens, brackets, and more.
paq {'tpope/vim-surround'}

-- Repeat support for surround and other plugins.
paq {'tpope/vim-repeat'}

-- Comment stuff out using 'gc'.
paq {'tpope/vim-commentary'}

-- Pairs of handy bracket mappings.
paq {'tpope/vim-unimpaired'}

-- Fuzzy-find everything!
paq {'junegunn/fzf.vim'}
    vim.cmd([[
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
    ]])

-- Format tables and calculate stuff in them.
paq {'dhruvasagar/vim-table-mode'}

-- cx for exchange operations.
paq {'tommcdo/vim-exchange'}

-- 'e' text object is the entire file.
paq {'kana/vim-textobj-entire'}
-- Needed for vim-textobj-entire.
paq {'kana/vim-textobj-user'}

-- Snippets, duh!
paq {'SirVer/ultisnips'}
    vim.g.UltiSnipsExpandTrigger = "<Tab>"
    vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- In Ruby, insert 'end' statements automatically.
paq {'tpope/vim-endwise'}

-- Dead simple personal wiki plugin.
paq {'blinry/vimboy'}

-- Asynchronous code linting and fixing
--paq {'w0rp/ale'}
--    let g:ale_linters = {
--    \    'rust': ['cargo'],
--    \    'glsl': ['glslang']
--    \}
--    let g:ale_fixers = {
--    \   'c': ['clang-format'],
--    \   'arduino': ['clang-format'],
--    \   'glsl': ['clang-format'],
--    \   'css': ['prettier'],
--    \   'haskell': ['hindent'],
--    \   'html': ['prettier'],
--    \   'json': ['prettier'],
--    \   'javascript': ['prettier'],
--    \   'vue': ['prettier']
--    \}
--    "\   'svelte': ['prettier'],
--    "\   'ruby': ['rufo'],
--    "\   'python': ['black'],
--
--    "let g:ale_linters_aliases = {
--    "\}
--    let g:ale_linters_explicit = 1
--    let g:ale_fix_on_save = 1
--    " Mappings in the style of unimpaired-next
--    nmap <silent> [W <Plug>(ale_first)
--    nmap <silent> [w <Plug>(ale_previous)
--    nmap <silent> ]w <Plug>(ale_next)
--    nmap <silent> ]W <Plug>(ale_last)

-- Asynchronous builds
--paq {'tpope/vim-dispatch'}
--paq {'radenling/vim-dispatch-neovim'}

-- Observe EditorConfig coding style settings.
paq {'editorconfig/editorconfig-vim'}

-- Additional text objects.
paq {'wellle/targets.vim'}

-- Better support for various filetypes.
paq {'slim-template/vim-slim'}
paq {'tikhomirov/vim-glsl'}
paq {'rust-lang/rust.vim'}
paq {'matze/vim-lilypond'}
paq {'philj56/vim-asm-indent'}
paq {'mxw/vim-jsx'}
paq {'itchyny/vim-haskell-indent'}
paq {'neovimhaskell/haskell-vim'}
paq {'calviken/vim-gdscript3'}
paq {'dag/vim-fish'}
paq {'907th/vim-auto-save'}

-- Colors, hidden Characters.
vim.cmd("colorscheme velvetopia")
vim.opt.termguicolors = true -- Use 'gui' highlight attributes instead of cterm.
vim.opt.list = true -- Show whitespace characters...
vim.opt.listchars = { tab = '› ', trail = '·', extends = '❭', precedes = '❬' } -- ... like this!
vim.cmd("au InsertLeave * :set listchars+=trail:·") -- Show trailing whitespace in all modes...
vim.cmd("au InsertEnter * :set listchars-=trail:·") -- ... except in insert mode.
vim.opt.showbreak ="↳" -- Display this character in front of wrapped lines.

-- Backup, undo, swap.
vim.opt.swapfile = false -- Don't keep swap files.
vim.opt.undofile = true -- Keep undo files.
vim.opt.backupcopy = "yes" -- When saving, make a copy, then overwrite the original file.
                              -- This is required for parcel's Hot Module Reload.
vim.g.netrw_dirhistmax = 0 -- Don't write a .netrwhist file.

-- Search.
vim.opt.ignorecase = true -- Ignore case in search patterns...
vim.opt.smartcase = true -- ... unless pattern contains upper case charecters.
vim.opt.hlsearch = false -- Don't highlight other search matches.
vim.opt.inccommand = "nosplit" -- Show preview of substitutions while typing.

-- Editing.
vim.opt.joinspaces = false -- When joining lines, don't insert two spaces after punctuation.

-- Indentation, line break.
local indent = 4
vim.opt.tabstop = indent -- A <Tab> is 4 characters long.
vim.opt.softtabstop = indent -- When editing indentations, edit 4 characters at once.
vim.opt.shiftwidth = indent -- Use 4 spaces when autoindenting.
vim.opt.expandtab = true -- On a <Tab>, insert spaces.
vim.opt.colorcolumn = "+1" -- Draw a line after 'textwidth'.
vim.opt.breakindent = true -- Keep indentation when wrapping lines.

-- History, command mode.
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:list,full" -- Tab-complete to longest common match, then show all matches.

-- User interface.
vim.opt.mouse = "a" -- Enable mouse use in all modes.
vim.opt.timeout = false -- Don't timeout on mappings.
vim.opt.startofline = false -- Keep cursor in the same column for many commands.
vim.opt.shell = '/bin/bash'
vim.opt.clipboard = { 'unnamed' , 'unnamedplus' } -- Use * and + in yank/paste operations.
vim.opt.lazyredraw = true -- Redraw only when we need to.
vim.opt.splitright = true -- Open vertical splits on the right side.
vim.opt.splitbelow = true -- Open horizontal splits on the bottom

-- Working with buffers.
vim.opt.hidden = true

-- Spell checking.
vim.opt.dictionary = '/usr/share/dict/american-english,/usr/share/dict/german'

-- MAPPINGS

-- Expand %% to the directory of the curent file.
map('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", {expr = true})

-- Bubble lines
map('n', '<C-k>', '[e')
map('n', '<C-j>', ']e')
map('v', '<C-k>', '[egv')
map('v', '<C-j>', ']egv')

-- Toggle search highlight.
map('n', '<Leader><Space>', '<Cmd>lua vim.o.hlsearch = not vim.o.hlsearch<CR>')

-- Add more undo-steps when writing prose.
for _, v in pairs({'.', '?', '!', ','}) do
  map('i', v, v..'<C-g>u')
end

-- Underline the current line with - or =.
map('n', '<Leader>-', '"ayy"ap:s/./-/g<CR>')
map('n', '<Leader>=', '"ayy"ap:s/./=/g<CR>')

-- Mark bulleted item as done
map('n', '+', ':s/^\\s*\\zs[-x~?]/+<CR>:w<CR>')

-- Save and restore sessions.
local sessions_dir = '~/.local/share/nvim/sessions/'
map('n', '<Leader>ss', ':mks! ' .. sessions_dir)
map('n', '<Leader>sr', ':so ' .. sessions_dir)

-- Edit snippets.
map('n', '<Leader>s', '<Cmd>UltiSnipsEdit<CR>')

-- AUTOCOMMANDS

-- When opening a file, always jump to the last known cursor position.
vim.cmd([[autocmd bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zv' | let b:doopenfold = 1 | endif]])

-- Resize splits when the window is resized.
vim.cmd('au Vimresized * :wincmd =')

-- Location of my private wiki.
vim.cmd('au BufRead,BufNewFile ~/permanent/wiki/* set ft=vimboy')

-- Location of the Prototype Fund wiki.
vim.cmd('au BufRead,BufNewFile ~/permanent/pf2-wiki/* set ft=vimboy')

-- Highlight second-level markdown headings properly.
vim.cmd([[syn match Special '---[-]*']])

-- Don't create temporary files of gopass secrets.
vim.cmd('au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile')
