vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
  severity_sort = true,
  update_in_insert = false, -- :NFO: This might need changing to true later.
  float = {
    border = "rounded",
  },
})
