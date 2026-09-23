return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
    },
    opts = {
        defaults = {
            file_ignore_patterns = { "%.git/", "node_modules/" },
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        local previewers = require("telescope.previewers")

        local image_exts = { "png", "jpg", "jpeg", "webp", "gif", "bmp" }

        local custom_previewer_maker = function(filepath, bufnr, preview_opts)
            preview_opts = preview_opts or {}
            filepath = vim.fn.expand(filepath)
            local ext = vim.fn.fnamemodify(filepath, ":e"):lower()

            if vim.tbl_contains(image_exts, ext) then
                vim.api.nvim_buf_call(bufnr, function()
                    vim.fn.termopen({ "chafa", filepath })
                end)
            else
                previewers.buffer_previewer_maker(filepath, bufnr, preview_opts)
            end
        end

        opts.defaults = opts.defaults or {}
        opts.defaults.buffer_previewer_maker = custom_previewer_maker

        telescope.setup(opts)
    end,
}
