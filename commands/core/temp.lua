local M = {}
function M.genTemp(name,left,right)
  return {
		name = name,
		callback = function ()
			local current_bufnr = vim.fn.bufnr('%')
			if not current_bufnr then
			  return
			end
			local ok,line_mode = pcall(vim.api.nvim_buf_get_var,current_bufnr, 'command_line_mode');
			if line_mode == "v" then
			local ok1,select_info = pcall(vim.api.nvim_buf_get_var,current_bufnr, 'command_select_info');
			if not select_info or not line_mode then
			  vim.notify("pleace first runcommand");
			  return
			else
			end
			local replacement = {left..select_info.selected_text..right};
      vim.api.nvim_buf_set_text(current_bufnr, select_info.start_line - 1, select_info.start_col - 1, select_info.end_line - 1, select_info.end_col, replacement) -- end
      elseif line_mode == 'n' then
        local cursor_pos = vim.fn.getpos('.');
        local row = cursor_pos[2]
        local col = cursor_pos[3]
			  local replacement = {left..''..right};
        -- 获取当前光标所在位置
        local cursor = vim.fn.getcurpos()
        local current_line = cursor[2]
        local current_col = cursor[3]
        local movelinelen = #replacement;
        local emptyline = {};
        for i = 1, movelinelen, 1 do
          table.insert(emptyline,"");
        end
        -- 在当前行指定列插入文本
        vim.api.nvim_buf_set_text(0, current_line - 1, current_col - 1, current_line - 1, current_col - 1, replacement)

        -- 获取当前行及以下的所有文本
        local lines_below = vim.api.nvim_buf_get_lines(0, current_line - 1, -1, false)
        
        -- 在当前行后插入一个空行，将下面的文本整体往后移动
        vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, emptyline)

        -- 将修改后的文本替换回缓冲区
        vim.api.nvim_buf_set_lines(0, current_line, -1, false, lines_below)
			end
		end
  }
end
-- @param name string
-- @param replacement table {}
function M.insertTemp(name,replacement)
      print(vim.inspect(replacement))
  return {
		name = name,
		callback = function ()
			local current_bufnr = vim.fn.bufnr('%')
			if not current_bufnr then
			  return
			end
      -- 获取当前光标所在位置
      local cursor = vim.fn.getcurpos()
      local current_line = cursor[2]
      local current_col = cursor[3]
      local movelinelen = #replacement;
      local emptyline = {};
      for i = 1, movelinelen, 1 do
        table.insert(emptyline,"");
      end
      -- 在当前行指定列插入文本
      vim.api.nvim_buf_set_text(0, current_line - 1, current_col - 1, current_line - 1, current_col - 1, replacement)

      -- 获取当前行及以下的所有文本
      local lines_below = vim.api.nvim_buf_get_lines(0, current_line - 1, -1, false)

      -- 在当前行后插入一个空行，将下面的文本整体往后移动
      vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, emptyline)

      -- 将修改后的文本替换回缓冲区
      vim.api.nvim_buf_set_lines(0, current_line, -1, false, lines_below)
		end
  }
end
return M
