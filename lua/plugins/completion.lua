return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  opts = {
    keymap = { preset = "super-tab" },
    sources = {
      default = { "lsp", "path", "snippets" },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        max_height = 10,
        draw = {
          treesitter = { "lsp" },
        },
      },
    },
    signature = { enabled = true },
  },
}
