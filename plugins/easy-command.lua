function append_empty_lines()
  -- Get the total number of lines in the current buffer
  local line_count = vim.api.nvim_buf_line_count(0)

  -- If the number of lines is less than 10
  if line_count < 10 then
    -- Create a table with 50 empty strings
    local empty_lines = {}
    for i = 1, 50 do
      table.insert(empty_lines, "")
    end

    -- Append the empty lines at the end of the buffer
    vim.api.nvim_buf_set_lines(0, line_count, -1, false, empty_lines)
  end
end

function write_to_temp_file(content)
  local tempfile = os.tmpname()
  local file = io.open(tempfile, "w")
  file:write(content)
  file:close()
  return tempfile
end

return {
  dir = vim.loop.os_homedir() .. "/.config/nvim/lua/user/plugins/easy-commands.nvim",
  -- "LintaoAmons/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
   local config = require("user.commands")
   -- require("easy-commands").setup(config)
    require("easy-commands").setup(config)
  end,
}
-- return {}
