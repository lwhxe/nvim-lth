return {
  "lervag/vimtex",
  lazy = false,
  ft = { "tex", "latex" },
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      out_dir = "build",
      continuous = 1,
    }
    vim.g.vimtex_view_forward_search_on_start = false
  end,
}
