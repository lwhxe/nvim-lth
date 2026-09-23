return {
  "nvim-telescope/telescope.nvim",
  init = function()
    local math_dir = vim.fn.expand("~/math")

    local function complete_math_dirs(ArgLead, CmdLine, CursorPos)
      local line_until_cursor = CmdLine:sub(1, CursorPos)
      local words = vim.split(line_until_cursor, "%s+", { trimempty = true })

      if #words <= 1 or (#words == 2 and not line_until_cursor:match("%s$")) then
        local pattern = math_dir .. "/" .. ArgLead .. "*"
        local paths = vim.fn.glob(pattern, false, true)
        local results = {}
        for _, path in ipairs(paths) do
          if vim.fn.isdirectory(path) == 1 then
            local rel = path:sub(#math_dir + 2)
            if rel ~= "" then
              table.insert(results, rel)
            end
          end
        end
        return results
      end

      return {}
    end

    vim.api.nvim_create_user_command("MathNew", function(cmd)
      if #cmd.fargs == 0 then
        vim.notify("Error: Usage is :MathNew <dir> <filename>", vim.log.levels.ERROR)
        return
      end

      local dir, filename
      if #cmd.fargs >= 2 then
        dir = cmd.fargs[1]
        filename = cmd.fargs[2]
      else
        dir = "."
        filename = cmd.fargs[1]
      end

      if not filename:match("%.tex$") then
        filename = filename .. ".tex"
      end

      local filepath = (dir == ".") and (math_dir .. "/" .. filename) or (math_dir .. "/" .. dir .. "/" .. filename)
      local parent_dir = vim.fn.fnamemodify(filepath, ":h")
      vim.fn.mkdir(parent_dir, "p")

      local is_new = vim.fn.filereadable(filepath) == 0

      vim.cmd("edit " .. vim.fn.fnameescape(filepath))

      if is_new then
        local title = vim.fn.fnamemodify(filepath, ":t:r")
        local template = {
          "\\documentclass{article}",
          "\\usepackage{amsmath,amssymb}",
          "",
          "\\title{" .. title .. "}",
          "\\date{\\today}",
          "",
          "\\begin{document}",
          "\\maketitle",
          "",
          "Notes go here.",
          "",
          "\\end{document}",
        }
        vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
        vim.cmd("write")
        vim.api.nvim_win_set_cursor(0, { 10, 0 })
      end
    end, { nargs = "+", complete = complete_math_dirs })

    vim.api.nvim_create_user_command("MathOpen", function()
      local find_cmd
      if vim.fn.executable("fd") == 1 then
        find_cmd = { "fd", "--type", "f", "-e", "tex" }
      elseif vim.fn.executable("rg") == 1 then
        find_cmd = { "rg", "--files", "-g", "*.tex" }
      else
        find_cmd = { "find", ".", "-type", "f", "-name", "*.tex" }
      end

      require("telescope.builtin").find_files({
        prompt_title = "< Math Notes (.tex) >",
        cwd = math_dir,
        find_command = find_cmd,
      })
    end, {})

    vim.keymap.set("n", "<leader>mo", "<cmd>MathOpen<cr>", { desc = "Open Math Notes" })
    vim.keymap.set("n", "<leader>mn", ":MathNew ", { desc = "Create New Math Note" })
  end,
}
