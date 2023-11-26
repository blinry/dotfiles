return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        {
            "nvim-tree/nvim-web-devicons",
        },
        {
            "SmiteshP/nvim-navic",
            opts = function()
                return {
                    lsp = {
                        auto_attach = true,
                    },
                }
            end,
        },
    },
    opts = {
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "filename" },
            lualine_c = {
                {
                    function()
                        return require("nvim-navic").get_location()
                    end,
                    cond = function()
                        return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                    end,
                },
            },
            lualine_x = {},
            lualine_y = { "location" },
            lualine_z = { "progress" },
        },
    },
}
