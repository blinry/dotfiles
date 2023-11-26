return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<cr>",
                    node_incremental = "<cr>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
    build = ":TSUpdate",
}
