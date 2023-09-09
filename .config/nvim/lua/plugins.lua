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
    "hrsh7th/nvim-cmp", -- Completion engine.
    "hrsh7th/cmp-nvim-lsp", -- Completions for LSP.
    'hrsh7th/cmp-path', -- Completions for path names.
    'hrsh7th/cmp-cmdline', -- Completions for the command line.
    'quangnguyen30192/cmp-nvim-ultisnips', -- Completions for UltiSnips.
    "nvim-treesitter/nvim-treesitter", -- Advanced syntax highlighting.
    "savq/paq-nvim", -- Let paq manage itself.
    "SirVer/ultisnips", -- Snippet support.
    "tommcdo/vim-exchange", -- Exchange visual selection using "X".
    "gcmt/taboo.vim", -- Give names to tabs.
    "907th/vim-auto-save", -- Autosave in some filetypes.
    "tpope/vim-commentary", -- Toggle comments using "gc".
    "tpope/vim-endwise", -- In Ruby, insert "end" statements automatically.
    "tpope/vim-obsession", -- Automatically update sessions.
    "tpope/vim-fugitive", -- Tight Git integration.
    "tidalcycles/vim-tidal", -- TidalCycles support.
    "jbyuki/instant.nvim", -- Coediting.
    "h-hg/fcitx.nvim", -- Disable/enable second input method automatically.
}

-- nvim-cmp configuration.
local cmp = require "cmp"
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = { ['<CR>'] = cmp.mapping.confirm({ select = true }) },
    sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "ultisnips" } })
})
cmp.setup.cmdline(":", { sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }) })

--- Treesitter configuration.
require "nvim-treesitter.configs".setup { ensure_installed = "all", highlight = { enable = true } }

-- fzf configuration.
vim.keymap.set("n", ";", "<Cmd>Buffers<CR>")
vim.keymap.set("n", "<C-p>", "<Cmd>Files<CR>")
vim.g.fzf_preview_window = {}

-- UltiSnips configuration.
vim.g.UltiSnipsExpandTrigger = "<Tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- Copilot configuration
vim.g.copilot_filetypes = { vimboy = false, mail = false }

-- Taboo configuration.
vim.g.taboo_modified_tab_flag = ""

-- vim-tidal configuration.
vim.g.tidal_target = "terminal"

-- instant configuration.
vim.g.instant_username = "blinry"
