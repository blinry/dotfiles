return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            highlight = { enable = true }
        })
    end,
    build = ":TSUpdate",
}
