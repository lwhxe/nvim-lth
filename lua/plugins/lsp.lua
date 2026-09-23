return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "clangd",
                "rust_analyzer",
                "pyright",
                "lua_ls",
                "vimls",
                "bashls",
                "intelephense",
                "zls",
                "omnisharp",
                "jdtls",
                "html",
                "cssls",
                "texlab",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            -- Keymaps fire once per buffer, the moment any LSP client attaches.
            -- This is the current recommended pattern (replaces the old
            -- on_attach passed into .setup{}), and it's global — one autocmd
            -- covers every language server, not one callback per server.
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", {}),
                callback = function(args)
                    local opts = { buffer = args.buf, silent = true }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", function()
                        vim.ui.input({ prompt = "New Name: " }, function(new_name)
                            vim.lsp.buf.rename(new_name)
                        end)
                    end, { desc = "Rename symbol (empty prompt)" })
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })

            -- Global defaults applied to every server, via the special '*' key.
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- Per-server override: lua_ls needs to know `vim` is a real global,
            -- or every vim.* call in your own config throws a false warning.
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })

            -- mason-lspconfig's automatic_enable (on by default in v2) already
            -- calls vim.lsp.enable for everything in lsp.lua's ensure_installed
            -- list. fish_lsp and asm_lsp aren't Mason packages, so they need
            -- enabling by hand.
            vim.lsp.enable({ "fish_lsp", "asm_lsp" })
        end,
    },
}
