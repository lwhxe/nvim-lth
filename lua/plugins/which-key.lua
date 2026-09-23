return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "classic",
        delay = function(ctx)
            return ctx.plugin and 0 or 200
        end,
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)

        -- Register group descriptions for key prefixes used across your config
        wk.add({
            { "<leader>f", group = "Find / Telescope" },
            { "<leader>m", group = "Math Notes" },
            { "<leader>z", group = "Zettelkasten" },
            { "<leader>c", group = "Code / LSP" },
            { "<leader>l", group = "LaTeX / VimTeX" },
        })
    end,
}
