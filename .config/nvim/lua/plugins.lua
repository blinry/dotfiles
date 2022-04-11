-- Intall paq-nvim, if it is not installed.
local install_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", install_path
    })
end

require "paq" {
    "farmergreg/vim-lastplace", -- Restore last cursor position when opening files.
    "dhruvasagar/vim-table-mode", -- Format tables and calculate stuff in them.
    "editorconfig/editorconfig-vim", -- Observe EditorConfig coding style settings.
    "github/copilot.vim", -- GitHub Copilot
    "junegunn/fzf.vim", -- Fuzzy-find everything!
    "neovim/nvim-lspconfig", -- A collection of LSP configurations.
    "nvim-treesitter/nvim-treesitter", -- Advanced syntax highlighting.
    "savq/paq-nvim", -- Let paq manage itself.
    "SirVer/ultisnips", -- Snippet support.
    "tommcdo/vim-exchange", -- Exchange visual selection using "X".
    "gcmt/taboo.vim", -- Give names to tabs.
    "907th/vim-auto-save", -- Autosave in some filetypes.
    "tpope/vim-commentary", -- Toggle comments using "gc".
    "tpope/vim-endwise", -- In Ruby, insert "end" statements automatically.
    "tpope/vim-obsession", -- Automatically update sessions.
    "tpope/vim-sleuth", -- Detect indentation settings automatically.
    "tpope/vim-fugitive" -- Tight Git integration.
}

--- Treesitter configuration.
require"nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {enable = true}
}

-- fzf configuration.
vim.keymap.set("n", ";", "<Cmd>Buffers<CR>")
vim.keymap.set("n", "<C-p>", "<Cmd>Files<CR>")
vim.g.fzf_preview_window = {}

-- UltiSnips configuration.
vim.g.UltiSnipsExpandTrigger = "<Tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- Copilot configuration
vim.g.copilot_filetypes = {vimboy = false, mail = false}

-- Taboo configuration.
vim.g.taboo_modified_tab_flag = ""
