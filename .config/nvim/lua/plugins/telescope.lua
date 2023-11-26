return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    --cmd = "Telescope",
    keys = {
        { ";", "<cmd>Telescope buffers<cr>" },
        { "<c-p>", "<cmd>Telescope find_files<cr>" },
        { "<Leader>/", "<cmd>Telescope live_grep<cr>" },
        --{ "\\", "<cmd>Telescope lsp_workspace_symbols<cr>" },
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            pickers = {
                buffers = { sort_lastused = true },
            },
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
        })
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("fzf")
    end,
}
