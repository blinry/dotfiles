local lspconfig = require("lspconfig")
local options = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

options.svelte = {}

options.vimls = {}

options.rnix = {}

options.tsserver = {
    on_attach = function(client)
        -- Disable formatting, I'm using Prettier.
        client.server_capabilities.document_formatting = false
    end
}

options.lua_ls = {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    }
                }
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
}

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

options.rust_analyzer = {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            }
        }
    }
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
