return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = "all",
        highlight = { enable = true }
    },
    build = ":TSUpdate",
}
