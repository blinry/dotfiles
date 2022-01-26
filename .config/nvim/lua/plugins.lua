local utils = require "utils"

-- Intall paq-nvim, if it is not installed.
local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path})
end

require "paq" {
    "blinry/vimboy", -- Dead simple personal wiki plugin.
    "dhruvasagar/vim-table-mode", -- Format tables and calculate stuff in them.
    "editorconfig/editorconfig-vim", -- Observe EditorConfig coding style settings.
    "github/copilot.vim", -- GitHub Copilot
    "junegunn/fzf.vim", -- Fuzzy-find everything!
    "neovim/nvim-lspconfig", -- A collection of LSP configurations.
    "nvim-treesitter/nvim-treesitter", -- Advanced syntax highlighting.
    "savq/paq-nvim", -- Let paq manage itself.
    "SirVer/ultisnips", -- Snippet support.
    "tommcdo/vim-exchange", -- Exchange visual selection using "X".
    "tpope/vim-commentary", -- Toggle comments using "gc".
    "tpope/vim-endwise", -- In Ruby, insert "end" statements automatically.
    "tpope/vim-fugitive" -- Tight Git integration.
}

--- Treesitter configuration.
require"nvim-treesitter.configs".setup {ensure_installed = "maintained", highlight = {enable = true}}

-- fzf configuration.
utils.map("n", ";", "<Cmd>Buffers<CR>")
utils.map("n", "<C-p>", "<Cmd>Files<CR>")

-- UltiSnips configuration.
vim.g.UltiSnipsExpandTrigger = "<Tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- Copilot configuration
vim.g.copilot_filetypes = {vimboy = false, mail = false}
