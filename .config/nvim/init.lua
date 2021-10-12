local fn = vim.fn

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = "," -- Use comma as a <Leader>.

-- Bootstrap paq-nvim.
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path}) end

require 'paq' {
    'savq/paq-nvim', -- Let paq manage itself.
    'neovim/nvim-lspconfig', -- Quickstart LSP configurations.
    'folke/tokyonight.nvim', -- Pretty colorscheme.
    --- Advanced syntax highlighting.
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            vim.cmd 'TSUpdate'
        end
    }, 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/playground', 'tpope/vim-fugitive', -- Git stuff!
    'tpope/vim-surround', -- Edit parens, brackets, and more.
    'tpope/vim-repeat', -- Repeat support for surround and other plugins.
    'tpope/vim-commentary', -- Comment stuff out using 'gc'.
    'tpope/vim-unimpaired', -- Pairs of handy bracket mappings.
    'tpope/vim-endwise', -- In Ruby, insert 'end' statements automatically.
    'junegunn/fzf.vim', -- Fuzzy-find everything!
    'dhruvasagar/vim-table-mode', -- Format tables and calculate stuff in them.
    'tommcdo/vim-exchange', -- cx for exchange operations.
    'kana/vim-textobj-entire', -- 'e' text object is the entire file.
    'kana/vim-textobj-user', -- Needed for vim-textobj-entire.
    'SirVer/ultisnips', -- Snippets, duh!
    -- 'blinry/vimboy', -- Dead simple personal wiki plugin.
    'editorconfig/editorconfig-vim', -- Observe EditorConfig coding style settings.
    'felipec/vim-sanegx', -- Workaround for broken gx.
    'wellle/targets.vim', -- Additional text objects.
    -- Better support for various filetypes.
    'slim-template/vim-slim', 'tikhomirov/vim-glsl', 'rust-lang/rust.vim', 'matze/vim-lilypond', 'philj56/vim-asm-indent',
    'itchyny/vim-haskell-indent', 'neovimhaskell/haskell-vim', 'calviken/vim-gdscript3', 'dag/vim-fish', '907th/vim-auto-save'
}

-- Treesitter configuration.
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}, textobjects = {enable = true}, incremental_selection = {enable = true}}

-- fzf configuration.
map('n', ';', '<Cmd>Buffers<CR>')
map('n', '<C-p>', '<Cmd>Files<CR>')

-- UltiSnips configuration.
vim.g.UltiSnipsExpandTrigger = "<Tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- LSP configuration.
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
-- require('lspconfig').solargraph.setup {on_attach = custom_lsp_attach}
require('lspconfig').svelte.setup {}
require('lspconfig').sumneko_lua.setup {
    cmd = {"lua-language-server"},
    root_dir = require('lspconfig').util.root_pattern(".git", "init.lua"),
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

local prettier = {formatCommand = "prettier --stdin --stdin-filepath ${INPUT}", formatStdin = true}

require"lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua", "javascript", "html", "css", "json"},
    settings = {
        rootMarkers = {".git", "init.lua"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
                    formatStdin = true
                }
            },
            javascript = {prettier},
            html = {prettier},
            css = {prettier},
            json = {prettier}
        }
    }
}
require('lspconfig').vimls.setup {}

-- require('lspconfig').denols.setup {}

-- require('lspconfig').efm.setup {
--    settings = {languages = {}},
--    filetypes = {'javascript'},
--    on_attach = function(client)
--        -- mappings(client)
--        client.resolved_capabilities.document_formatting = true
--    end
-- }
-- require('lspconfig').tsserver.setup {on_attach = custom_lsp_attach}
require('lspconfig').html.setup {cmd = {"vscode-html-languageserver", "--stdio"}}
vim.api.nvim_command [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

-- Colors, hidden Characters.
vim.g.tokyonight_style = "night"
vim.cmd("colorscheme tokyonight")
vim.opt.termguicolors = true -- Use 'gui' highlight attributes instead of cterm.
vim.opt.list = true -- Show whitespace characters...
vim.opt.listchars = {tab = '› ', trail = '·', extends = '❭', precedes = '❬'} -- ... like this!
vim.cmd("au InsertLeave * :set listchars+=trail:·") -- Show trailing whitespace in all modes...
vim.cmd("au InsertEnter * :set listchars-=trail:·") -- ... except in insert mode.
vim.opt.showbreak = "↳" -- Display this character in front of wrapped lines.

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
vim.opt.clipboard = {'unnamed', 'unnamedplus'} -- Use * and + in yank/paste operations.
vim.opt.lazyredraw = true -- Redraw only when we need to.
vim.opt.splitright = true -- Open vertical splits on the right side.
vim.opt.splitbelow = true -- Open horizontal splits on the bottom
-- vim.opt.number = true -- Show line numbers.

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
for _, v in pairs({'.', '?', '!', ','}) do map('i', v, v .. '<C-g>u') end

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

vim.cmd([[autocmd bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zv' | let b:doopenfold = 1 | endif]]) -- When opening a file, always jump to the last known cursor position.
vim.cmd('au Vimresized * :wincmd =') -- Resize splits when the window is resized.
vim.cmd('au BufRead ~/permanent/wiki/* set ft=vimboy') -- Location of my private wiki.
vim.cmd('au BufRead,BufNewFile ~/permanent/pf2-wiki/* set ft=vimboy') -- Location of the Prototype Fund wiki.
vim.cmd([[syn match Special '---[-]*']]) -- Highlight second-level markdown headings properly.
vim.cmd('au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile') -- Don't create temporary files of gopass secrets.
