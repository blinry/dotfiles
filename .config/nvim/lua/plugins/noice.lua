return {
    "folke/noice.nvim",
    dependencies = {
        {
            "rcarriga/nvim-notify",
            opts = {
                timeout = 1000,
            },
            config = function()
                vim.o.termguicolors = true
            end,
        },
    },
    opts = {
        cmdline = {
            view = "cmdline",
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,
            --command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "written" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = "fewer lines" },
                    },
                },
                opts = { skip = true },
            },
        },
    },
}
