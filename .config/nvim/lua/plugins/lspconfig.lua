return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "creativenull/efmls-configs-nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            local configs = {
                svelte = {},
                vimls = {},
                rnix = {},
                bashls = {},
                tsserver = {
                    on_attach = function(client)
                        -- Disable formatting, I'm using Prettier.
                        client.server_capabilities.document_formatting = false
                    end,
                },
                lua_ls = {
                    on_init = function(client)
                        local path = client.workspace_folders[1].name
                        if not vim.loop.fs_stat(path .. "/.luarc.json")
                            and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
                        then
                            client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            vim.env.VIMRUNTIME,
                                        },
                                    },
                                },
                            })
                            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                        end
                        return true
                    end,
                },
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy",
                            },
                        },
                    },
                },
                --efm = require("config.efm"),
            }

            -- Setup all language servers.
            for lsp, opts in pairs(configs) do
                opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
                lspconfig[lsp].setup(opts)
            end

            --vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    --vim.keymap.set('n', '<space>wl', function()
                    --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    --end, opts)
                    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/playground",
        cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
}
