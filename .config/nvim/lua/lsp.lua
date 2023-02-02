local lspconfig = require("lspconfig")
local options = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

options.svelte = {}

options.vimls = {}

options.rnix = {}

-- options.tsserver = {
--    on_attach = function(client)
--        -- Disable formatting, I'm using Prettier.
--        client.server_capabilities.document_formatting = false
--    end
-- }

--options.sumneko_lua = {
--    cmd = {"lua-language-server"},
--    root_dir = lspconfig.util.root_pattern(".git", "init.lua"),
--    settings = {
--        Lua = {
--            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
--            diagnostics = {globals = {'vim'}},
--            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
--            telemetry = {enable = false}
--        }
--    }
--}

local prettierFiletypes = {
    "javascript", "typescript", "html", "css", "scss", "less", "json", "yaml"
}
local filetypes = {}
local efmSettingsLanguages = {}
for _, filetype in ipairs(prettierFiletypes) do
    efmSettingsLanguages[filetype] = { { formatCommand = "prettierd ${INPUT}", formatStdin = true } }
    table.insert(filetypes, filetype)
end

-- efmSettingsLanguages["lua"] = {
--    {
--        formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-keep-simple-control-block-one-line --no-break-after-operator --column-limit=100 --break-after-table-lb",
--        formatStdin = true
--    }
-- }
-- table.insert(filetypes, "lua")

options.efm = {
    init_options = { documentFormatting = true },
    filetypes = filetypes,
    settings = { rootMarkers = { ".git", "init.lua" }, languages = efmSettingsLanguages }
}

-- Setup all language servers.
for lsp, opts in pairs(options) do
    opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
    lspconfig[lsp].setup(opts)
end

-- Format automatically on save.
vim.api.nvim_create_autocmd("bufwritepre", {
    callback = function()
        vim.lsp.buf.format({
            -- Don't use Copilot LSP for formatting.
            filter = function(client) return client.name ~= "copilot" end
        })
    end
})
