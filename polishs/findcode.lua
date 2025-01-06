local editor = require "user.core.util.editor"
local M = {}

local function UpperCaseFirstLetter(select_text)
  local newstr = ""
  local ops = string.find(select_text, "_")
  if ops then
    for w in string.gmatch(select_text, "%w+") do
      newstr = newstr .. string.upper(string.sub(w, 1, 1)) .. string.sub(w, 2)
    end
  end

  return newstr
end

local function lowerCase(str)
  str = string.gsub(str, "%u", function(c) return "_" .. string.lower(c) end)
  return str
end

-- 选中的单词下划线变驼峰
function M.changeCase()
  local options = {
    "hump",
    "underline",
  }
  local c_buffer = vim.api.nvim_get_current_buf()
  local start_p, end_p = unpack(editor.selections.get_positions())
  local select_text = editor.selections.get_selected()
  local get_line = editor.buf.read.get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.ui.select(options, {
    prompt = "change world case:",
    format_item = function(item) return "change word to " .. item end,
  }, function(choice)
    if choice == "hump" then
      if string.find(select_text, "_") then
        vim.api.nvim_buf_set_lines(c_buffer, row - 1, row, true, {
          string.sub(get_line, 0, start_p["col"] - 1)
            .. UpperCaseFirstLetter(select_text)
            .. string.sub(get_line, end_p["col"] + 1, #get_line),
        })
      end
    else
      if string.find(select_text, "%u") then
        vim.api.nvim_buf_set_lines(c_buffer, row - 1, row, true, {
          string.sub(get_line, 0, start_p["col"] - 1)
            .. lowerCase(select_text)
            .. string.sub(get_line, end_p["col"] + 1, #get_line),
        })
      end
    end
  end)
end

function M.setup()
  vim.keymap.set(
    {
      "v",
    },
    "<leader>wu",
    M.changeCase,
    {
      desc = "quick change case",
    }
  )
end

return M
