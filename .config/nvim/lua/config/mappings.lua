-- Expand %% to the directory of the curent file.
vim.keymap.set("c", "%%", function()
    if vim.fn.getcmdtype() == ":" then
        return vim.fn.expand("%:h") .. "/"
    else
        return "%%"
    end
end, { expr = true })

-- Toggle search highlight.
vim.keymap.set("n", "<Leader><Space>", function()
    vim.opt.hlsearch = not vim.opt.hlsearch:get()
end)

-- Add more undo-steps when writing prose.
for _, v in pairs({ ".", "?", "!", "," }) do
    vim.keymap.set("i", v, v .. "<C-g>u")
end

-- Underline the current line with - or =.
for _, v in pairs({ "-", "=" }) do
    vim.keymap.set("n", "<Leader>" .. v, function()
        local len = #vim.api.nvim_get_current_line()
        local underline = string.rep(v, len)
        vim.api.nvim_put({ underline }, "l", true, true)
    end)
end

-- Mark bulleted item as done
vim.keymap.set("n", "+", function()
    vim.cmd("s/^\\s*\\zs[-x~?]/+")
    vim.cmd("w")
end)

-- Save and restore sessions.
local sessions_dir = "~/.local/share/nvim/sessions/"
vim.keymap.set("n", "<leader>ss", ":Obsession " .. sessions_dir)
vim.keymap.set("n", "<leader>sr", ":so " .. sessions_dir)

-- Show syntax element under cursor.
vim.keymap.set("n", "<F10>", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    col = col + 1

    local synIDrevealed = vim.fn.synID(row, col, true)
    local synIDtransparent = vim.fn.synID(row, col, false)

    local hi = vim.fn.synIDattr(synIDrevealed, "name")
    local trans = vim.fn.synIDattr(synIDtransparent, "name")
    local lo = vim.fn.synIDattr(vim.fn.synIDtrans(synIDrevealed), "name")

    print("hi<" .. hi .. "> trans<" .. trans .. "> lo<" .. lo .. ">")
end)
