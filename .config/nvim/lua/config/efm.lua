-- https://github.com/creativenull/efmls-configs-nvim/blob/main/doc/SUPPORTED_LIST.md

local languages = {
    lua = require('efmls-configs.formatters.stylua'),
}

for _, filetype in ipairs({ "javascript", "typescript", "html", "css", "scss", "less", "json", "jsonc", "yaml" }) do
    languages[filetype] = { require('efmls-configs.formatters.prettier_d') }
end

return {
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = { ".git", "init.lua" },
        languages = languages,
    },
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
}
