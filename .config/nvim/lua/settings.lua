-- Abbreviations for the Neovim API.
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

g.mapleader = "," -- Use comma as a <Leader>.

-- Colors, hidden Characters.
cmd("colorscheme velvetopia") -- My own little colorscheme.
opt.list = true -- Show whitespace characters...
opt.listchars = {tab = "› ", trail = "·", extends = "❭", precedes = "❬"} -- ... like this!

-- Show trailing whitespace in all modes...
vim.api.nvim_create_autocmd("insertleave", {
    callback = function()
        opt.listchars:append({trail = "·"})
    end
})
-- ... except in insert mode.
vim.api.nvim_create_autocmd("insertenter", {
    callback = function()
        opt.listchars:remove("trail")
    end
})

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
opt.colorcolumn = "+1" -- Draw a line after 'textwidth'.
opt.breakindent = true -- Keep indentation when wrapping lines.

-- History, command mode.
opt.wildignorecase = true
opt.wildmode = "longest:list,full" -- Tab-complete to longest common match, then show all matches.

-- User interface.
opt.mouse = "a" -- Enable mouse in all modes.
opt.timeout = false -- Don't timeout on mappings.
opt.shell = "/bin/bash"
opt.clipboard = {"unnamed", "unnamedplus"} -- Use * and + in yank/paste operations.
opt.lazyredraw = true -- Redraw only when we need to.
opt.splitright = true -- Open vertical splits on the right side.
opt.splitbelow = true -- Open horizontal splits on the bottom

-- Working with buffers.
opt.sessionoptions:append("globals") -- Save global variables to sessions, required for Taboo plugin.

-- Spell checking.
opt.dictionary = "/usr/share/dict/american-english,/usr/share/dict/german"
