return {
    "stevearc/conform.nvim",
    opts = function()
        local o = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        }
        return o
    end,
}
