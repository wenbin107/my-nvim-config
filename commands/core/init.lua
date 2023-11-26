-- local lsp = require('lspconfig')
local buffer = require('user.commands.core.buffer')
local M = {};
function M.restore_section(stored_selection)
  if stored_selection then
    -- vim.api.nvim_win_set_cursor(0, {stored_selection.start_line, stored_selection.start_col})
    vim.api.nvim_feedkeys('v', 'n', true)
    -- vim.api.nvim_win_set_cursor(0, {stored_selection.end_line, stored_selection.end_col})
    return 1
  end
  return 0
end
function M.get_select_info()
  local starts = buffer.get_mark('<');
  local ends = buffer.get_mark('>');
  -- local ends = vim.api.nvim_b>f_get_mark(0,">");
	local start_line = starts[1]
  local end_line = ends[1]
  local start_col = starts[2]
  local end_col = ends[2]
  local selections = {
    first_pos = starts,
    last_pos = ends
  }
  local replacement = buffer.get_text(selections);
  -- 存储选中内容和位置
  local stored_selection = {
    start_line = start_line,
    end_line = end_line,
    start_col = start_col,
    end_col = end_col,
    selected_table = replacement,
    selections = selections
  }
  
  return stored_selection;
end
-- 获取选中的内容和位置
function M.get_select_info_old()
	local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local start_col = vim.fn.col("'<")
  local end_col = vim.fn.col("'>")
  local selected_text = vim.api.nvim_buf_get_text(0, start_line - 1, start_col - 1, end_line - 1, end_col, {})[1];
  -- print(vim.inspect(selected_text);
  -- local selected_text = vim.fn.getreg(vim.fn.visualmode());
  -- 存储选中内容和位置
  local stored_selection = {
    start_line = start_line,
    end_line = end_line,
    start_col = start_col,
    end_col = end_col,
    selected_text = selected_text,
  }
  return stored_selection;
end
---@param cmdsList EasyCommand.Command[][]
---@return EasyCommand.Command[]
function M.combineCmds(cmdsList)
	local m = {}
	for _, cmds in ipairs(cmdsList) do
		for _, c in ipairs(cmds) do
			table.insert(m, c)
		end
	end
	return m
end

local function delete_js_function()
  -- 获取当前光标所在的行号
  local current_line = vim.fn.line('.')
  -- 查找函数定义的开始行
  local start_line = current_line
  while start_line > 1 do
    start_line = start_line - 1
    local line_content = vim.fn.getline(start_line)
    if line_content:match('^%s*function%s*%w*%s*%(.-%)%s*{')
      or line_content:match('^%s*class%s+%w+%s*{')
      or line_content:match('^%s*()%s*=>%s*{')
    then
      break
    end
  end

  -- 查找函数定义的结束行
  local end_line = current_line
  while end_line < vim.fn.line('$') do
    end_line = end_line + 1
    local line_content = vim.fn.getline(end_line)
    if line_content:match('^%s*}%s*$') then
      break
    end
  end

  -- 删除整个函数定义块
  if start_line < current_line and current_line < end_line then
    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, {})
  else
    print("No function or class definition found.")
  end
end
function M.delete_current_function()
  local ft = vim.bo.filetype;
  if ft == 'javascript' then
    pcall(delete_js_function);
    return
  end
  -- 获取当前光标位置
  local cursor_position = vim.fn.getpos('.')
  if not cursor_position then
    return
  end
  local line_number = cursor_position[2]

  -- 获取当前行的 LSP 信息
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
    position = {
      line = line_number - 1,  -- LSP 行号从 0 开始
      character = 0,
    }
  }

  -- 请求 LSP 获取当前行的语法信息
  vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, function(_, result, _)
    if result and result[1] then
      local range = result[1].range

      -- 删除函数定义所在的行
      vim.api.nvim_buf_set_lines(0, range.start.line, range.end_.line + 1, false, {})
    else
      print("No function definition found.")
    end
  end)
end

return M;
