return {
    "stevearc/conform.nvim",
    opts = function()
        local formatters_by_ft = {
            lua = { "stylua" },
        }
        local prettier_filetypes = { "html", "css", "javascript", "typescript", "json", "svelte" }
        for _, ft in ipairs(prettier_filetypes) do
            formatters_by_ft[ft] = { "prettierd" }
        end

        local o = {
            formatters_by_ft = formatters_by_ft,
            format_on_save = {
                timeout_ms = 2000,
                lsp_fallback = true,
            },
        }
        return o
    end,
}
