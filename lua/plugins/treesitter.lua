return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ensure_installed = {
      "c", "cpp", "rust", "asm",
      "python", "lua", "vim", "vimdoc", "bash", "fish",
      "typescript", "javascript", "tsx", "html", "css", "markdown", "markdown_inline",
      "c_sharp", "java", "php", "zig",
      "latex", "query", "regex",
    }

    require("nvim-treesitter").install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        pcall(function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end)
      end,
    })
  end,
}
