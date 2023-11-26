return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "quangnguyen30192/cmp-nvim-ultisnips",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "SirVer/ultisnips",
    },
    init = function()
        vim.g.UltiSnipsExpandTrigger = "<Tab>"
        vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
        vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"
    end,
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
                end,
            },
            mapping = {
                ["<cr>"] = cmp.mapping.confirm({ select = true }),
                ["<up>"] = cmp.mapping.select_prev_item(select_opts),
                ["<down>"] = cmp.mapping.select_next_item(select_opts),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "ultisnips" },
            }),
        })
        cmp.setup.cmdline(":", { sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }) })
    end,
}
