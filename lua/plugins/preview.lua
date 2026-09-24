return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.cmd("Lazy loading markdown-preview.nvim")
            vim.fn["mkdp#util#install"]()
        end,
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Browser Preview" },
        },
    },
    {
        "nvim-lua/plenary.nvim",
        config = function()
            vim.keymap.set("n", "<leader>bp", function()
                local port = 8000

                vim.fn.jobstart({ "python", "-m", "http.server", tostring(port) }, { detach = true })

                local cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
                vim.fn.jobstart({ cmd, "http://localhost:" .. port }, { detach = true })
            end, { desc = "Open current file in Browser" })
        end
    },
}
