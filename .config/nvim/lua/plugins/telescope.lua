return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim"
    },
    cmd = "Telescope",
    keys = {
        { ";", "<cmd>Telescope buffers<cr>" },
        { "<c-p>", "<cmd>Telescope find_files<cr>" },
    },
    setup = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require('telescope.actions').close,
                    },
                },
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- even more opts
                    }
                }
            }
        }
        require("telescope").load_extension("ui-select")
    end
}
