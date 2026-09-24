return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
        },
    },
    version = "*",
    opts = {
        snippets = { preset = "luasnip" },
        keymap = { preset = "super-tab" },
        sources = {
            -- Explicitly tell blink to fetch completions from all four providers
            default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            menu = {
                max_height = 10,
                draw = {
                    treesitter = { "lsp" },
                },
            },
        },
        signature = { enabled = true },
    },
    config = function(_, opts)
        require("blink.cmp").setup(opts)

        -- Define custom LuaSnip snippets
        local has_luasnip, ls = pcall(require, "luasnip")
        if has_luasnip then
            ls.add_snippets("tex", {
                ls.snippet("quest", {
                    ls.text_node({ "\\begin{question}[" }),
                    ls.insert_node(1, "Title / Topic"),
                    ls.text_node({ "]", "  " }),
                    ls.insert_node(2, "Type your question here..."),
                    ls.text_node({ "", "\\end{question}" }),
                }),
                ls.snippet("enumq", {
                    ls.text_node({ "\\begin{enumerate}[label=\\textbf{Q\\arabic*.}]", "  \\item " }),
                    ls.insert_node(1, "First question..."),
                    ls.text_node({ "", "\\end{enumerate}" }),
                }),
                ls.snippet("code", {
                    ls.text_node({ "\\begin{minted}{" }),
                    ls.insert_node(1, "Language"),
                    ls.text_node({ "}", "  " }),
                    ls.insert_node(2, "Code..."),
                    ls.text_node({ "", "\\end{minted}" }),
                }),
            })
        end
    end,
}
