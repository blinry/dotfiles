-- Resize splits when the window is resized.
vim.api.nvim_create_autocmd("vimresized", {command = "wincmd ="})

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

---- Ethersync development
--vim.api.nvim_create_autocmd({"textchanged", "textchangedi"}, {
--    pattern = os.getenv("HOME") .. "/wip/ethersync/output/*",
--    callback = function()
--        vim.cmd("silent write")
--    end
--})
