return {
    "nvim-telekasten/telekasten.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telekasten/calendar-vim",
        "nvim-telescope/telescope-media-files.nvim",
    },
    config = function()
        local home = vim.fn.expand("~/zettelkasten")

        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                media_files = {
                    filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
                    find_cmd = "fd",
                },
            },
        })
        telescope.load_extension("media_files")

        require("telekasten").setup({
            home = home,
            take_over_my_home = true,
            auto_set_filetypes = true,

            dailies = home .. "/daily",
            weeklies = home .. "/weekly",
            templates = home .. "/templates",
            image_subdir = "img",

            extension = ".md",
            new_note_filename = "title",
            uuid_type = "%Y%m%d%H%M",

            subdirs_in_zettel_type = true,
            show_tags_directory = true,
            plug_into_calendar = true,
            calendar_opts = {
                weeknm = 1,
                calendar_monday = 1,
            },

            install_after_paste = true,
            media_previewer = "telescope-media-files",
        })
    end,
    keys = {
        { "<leader>zp",       "<cmd>Telekasten panel<cr>",              desc = "Telekasten Command Palette" },
        { "<leader>zf",       "<cmd>Telekasten find_notes<cr>",         desc = "Find Notes by Title" },
        { "<leader>zg",       "<cmd>Telekasten search_notes<cr>",       desc = "Search (Grep) in Notes" },
        { "<leader>zt",       "<cmd>Telekasten show_tags<cr>",          desc = "Show / Search Tags" },
        { "<leader>zn",       "<cmd>Telekasten new_note<cr>",           desc = "Create New Note" },
        { "<leader>zN",       "<cmd>Telekasten new_templated_note<cr>", desc = "Create Templated Note" },
        { "<leader>zl",       "<cmd>Telekasten insert_link<cr>",        desc = "Insert Link to Note" },
        { "<leader>zb",       "<cmd>Telekasten show_backlinks<cr>",     desc = "Show Backlinks" },
        { "<leader>zr",       "<cmd>Telekasten rename_note<cr>",        desc = "Rename Note & Update Links" },
        { "<leader>zd",       "<cmd>Telekasten goto_today<cr>",         desc = "Go to Today's Daily Note" },
        { "<leader>zw",       "<cmd>Telekasten goto_thisweek<cr>",      desc = "Go to Weekly Note" },
        { "<leader>zc",       "<cmd>Telekasten show_calendar<cr>",      desc = "Open Calendar" },
        { "<leader>zi",       "<cmd>Telekasten paste_img_and_link<cr>", desc = "Paste Image from Clipboard" },
        { "<leader>zm",       "<cmd>Telekasten find_friends<cr>",       desc = "Find Media / Images" },
        { "<leader>z<space>", "<cmd>Telekasten toggle_todo<cr>",        desc = "Toggle Todo Checklist" },
    },
}
