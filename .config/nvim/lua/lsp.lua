local lspconfig = require("lspconfig")
local options = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

options.svelte = {}

options.vimls = {}

options.tsserver = {
    on_attach = function(client)
        -- Disable formatting, I'm using Prettier.
        client.resolved_capabilities.document_formatting = false
    end
}

options.sumneko_lua = {
    cmd = {"lua-language-server"},
    root_dir = lspconfig.util.root_pattern(".git", "init.lua"),
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            telemetry = {enable = false}
        }
    }
}

local prettier = {formatCommand = "prettier --stdin --stdin-filepath ${INPUT}", formatStdin = true}
options.efm = {
    init_options = {documentFormatting = true},
    filetypes = {"lua", "javascript", "html", "css", "json"},
    settings = {
        rootMarkers = {".git", "init.lua"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=120 --break-after-table-lb",
                    formatStdin = true
                }
            },
            javascript = {prettier},
            html = {prettier},
            css = {prettier},
            json = {prettier}
        }
    }
}

-- Setup all language servers.
for lsp, opts in pairs(options) do lspconfig[lsp].setup(opts) end

-- Format automatically on save.
vim.api.nvim_command "autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()"