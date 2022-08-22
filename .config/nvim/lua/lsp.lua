local lspconfig = require("lspconfig")
local options = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

options.svelte = {}

options.vimls = {}

options.tsserver = {
    on_attach = function(client)
        -- Disable formatting, I'm using Prettier.
        client.server_capabilities.document_formatting = false
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
local lua = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-keep-simple-control-block-one-line --no-break-after-operator --column-limit=100 --break-after-table-lb",
    formatStdin = true
}
options.efm = {
    init_options = {documentFormatting = true},
    filetypes = {"lua", "javascript", "html", "css", "json"},
    settings = {
        rootMarkers = {".git", "init.lua"},
        languages = {
            lua = {lua},
            javascript = {prettier},
            html = {prettier},
            css = {prettier},
            json = {prettier}
        }
    }
}

-- Setup all language servers.
for lsp, opts in pairs(options) do
    opts.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol
                                                                        .make_client_capabilities())
    lspconfig[lsp].setup(opts)
end

-- Format automatically on save.
vim.api.nvim_create_autocmd("bufwritepre", {
    callback = function()
        vim.lsp.buf.format()
    end
})
