return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            rust = { "rustfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
        },
        formatters = {
            clang_format = {
                prepend_args = {
                    "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}",
                },
            },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
}
