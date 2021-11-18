-- Abbreviations for the Neovim API.
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

g.mapleader = "," -- Use comma as a <Leader>.

-- Colors, hidden Characters.
cmd("colorscheme velvetopia") -- My own little colorscheme.
opt.termguicolors = true -- Use 'gui' highlight attributes instead of cterm.
opt.list = true -- Show whitespace characters...
opt.listchars = {tab = "› ", trail = "·", extends = "❭", precedes = "❬"} -- ... like this!
cmd("au InsertLeave * :set listchars+=trail:·") -- Show trailing whitespace in all modes...
cmd("au InsertEnter * :set listchars-=trail:·") -- ... except in insert mode.
opt.showbreak = "↳" -- Display this character in front of wrapped lines.

-- Backup, undo, swap.
opt.swapfile = false -- Don't keep swap files.
opt.undofile = true -- Keep undo files.
opt.backupcopy = "yes" -- When saving, make a copy, then overwrite the original file. (Required for parcel's Hot Module Reload.)
g.netrw_dirhistmax = 0 -- Don't write a .netrwhist file.

-- Search.
opt.ignorecase = true -- Ignore case in search patterns...
opt.smartcase = true -- ... unless pattern contains upper case charecters.
opt.hlsearch = false -- Don't highlight other search matches.
opt.inccommand = "nosplit" -- Show preview of substitutions while typing.

-- Editing.
opt.joinspaces = false -- When joining lines, don't insert two spaces after punctuation.

-- Indentation, line break.
local indent = 4
opt.tabstop = indent -- A <Tab> is 4 characters long.
opt.softtabstop = indent -- When editing indentations, edit 4 characters at once.
opt.shiftwidth = indent -- Use 4 spaces when autoindenting.
opt.expandtab = true -- On a <Tab>, insert spaces.
opt.colorcolumn = "+1" -- Draw a line after 'textwidth'.
opt.breakindent = true -- Keep indentation when wrapping lines.

-- History, command mode.
opt.wildignorecase = true
opt.wildmode = "longest:list,full" -- Tab-complete to longest common match, then show all matches.

-- User interface.
opt.mouse = "a" -- Enable mouse in all modes.
opt.timeout = false -- Don't timeout on mappings.
opt.startofline = false -- Keep cursor in the same column for many commands.
opt.shell = "/bin/bash"
opt.clipboard = {"unnamed", "unnamedplus"} -- Use * and + in yank/paste operations.
opt.lazyredraw = true -- Redraw only when we need to.
opt.splitright = true -- Open vertical splits on the right side.
opt.splitbelow = true -- Open horizontal splits on the bottom
-- opt.number = true -- Show line numbers.

-- Working with buffers.
opt.hidden = true -- Allow hiding buffers with modifications.

-- Spell checking.
opt.dictionary = "/usr/share/dict/american-english,/usr/share/dict/german"
