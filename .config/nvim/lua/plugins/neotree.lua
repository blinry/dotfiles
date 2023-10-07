return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker",
    },
    opts = {
        sources = {
            "filesystem",
            "git_status",
            "document_symbols",
        },
        source_selector = {
            winbar = false,
            sources = {
                { source = "filesystem" },
                { source = "git_status" },
                { source = "document_symbols" },
            },
        },
    },
    cmd = "Neotree",
    keys = {
        { "|", "<cmd>Neotree toggle<cr>" },
    },
}
