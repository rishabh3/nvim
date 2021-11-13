local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

cmp.setup(
    {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        mapping = {
            ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
            ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
            ["<C-x>"] = cmp.mapping.close(),
            ["<C-c>"] = cmp.mapping(
                cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                },
                {"i", "c"}
            ),
            ["<C-space>"] = cmp.mapping {
                i = cmp.mapping.complete(),
                c = function(_ --[[fallback]])
                    if cmp.visible() then
                        if not cmp.confirm {select = true} then
                            return
                        end
                    else
                        cmp.complete()
                    end
                end
            }
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lua"},
                {name = "zsh"},
                {name = "nvim_lsp"},
                {name = "path"},
                {name = "luasnip"},
                {name = "buffer", keyword_length = 5}
            }
        ),
        formatting = {
            format = lspkind.cmp_format {
                with_text = true,
                menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[api]",
                    path = "[path]",
                    luasnip = "[snip]",
                    gh_issues = "[issues]",
                    tn = "[TabNine]"
                }
            }
        },
        experimental = {
            native_menu = false
        }
    }
)

cmp.setup.cmdline(
    "/",
    {
        completion = {
            autocomplete = false
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp_document_symbol"}
            },
            {}
        )
    }
)

cmp.setup.cmdline(
    ":",
    {
        completion = {
            autocomplete = false
        },
        sources = cmp.config.sources(
            {
                {
                    name = "path"
                }
            },
            {
                {
                    name = "cmdline",
                    max_item_count = 20,
                    keyword_length = 4
                }
            }
        )
    }
)
