-- Resize splits when the window is resized.
vim.api.nvim_create_autocmd("vimresized", {command = "wincmd ="})

-- Location of my private wiki.
vim.api.nvim_create_autocmd({"bufnewfile", "bufread"}, {
    pattern = os.getenv("HOME") .. "/permanent/wiki/*",
    callback = function()
        vim.bo.filetype = "vimboy"
    end
})

-- Don't create temporary files of gopass secrets.
vim.api.nvim_create_autocmd({"bufnewfile", "bufread"}, {
    pattern = "/dev/shm/gopass.*",
    callback = function()
        vim.opt.swapfile = false
        vim.opt.backup = false
        vim.opt.undofile = false
    end
})

-- Don't continue comments on next line.
vim.api.nvim_create_autocmd("bufwinenter", {
    callback = function()
        vim.opt.formatoptions:remove({"o", "r"})
    end
})
