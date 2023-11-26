return {
    "RRethy/vim-illuminate",
    config = function()
        -- The default highlight is "Underline", let's change that!
        vim.api.nvim_create_autocmd({ "colorscheme" }, {
            pattern = { "*" },
            callback = function()
                vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
                vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
                vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
            end,
        })
        vim.api.nvim_exec_autocmds("User", { pattern = "colorscheme" })
    end,
}
