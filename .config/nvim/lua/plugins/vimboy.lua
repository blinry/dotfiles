return {
    dir = os.getenv("HOME") .. "/permanent/vimboy.nvim",
    ft = "vimboy",
    init = function()
        -- Location of my private wiki.
        vim.api.nvim_create_autocmd({ "bufnewfile", "bufread" }, {
            pattern = os.getenv("HOME") .. "/permanent/wiki/*",
            callback = function()
                vim.bo.filetype = "vimboy"
            end
        })
    end
}
