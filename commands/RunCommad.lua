
local get_select_info = require("user.commands.core").get_select_info
return function(myCommands)
  if not myCommands then
    myCommands = {}
  end

return {
	{
		  name = "RunCommand",
		  callback = function()
			  -- 获取当前模式
				local current_bufnr = vim.fn.bufnr('%')
			  local line_mode = vim.api.nvim_get_mode().mode;
    		local ft = vim.bo.ft;
			  if line_mode == 'v' or line_mode == 'V' then
			  	vim.cmd("normal "..line_mode)
		      local select_info = get_select_info();
		  	  if current_bufnr then
		        vim.api.nvim_buf_set_var(current_bufnr,'command_select_info',select_info)
		  	  end
		    end

			-- 获取当前缓冲区号
		  	-- 将 line_mode 存储到当前缓冲区中
		  	if current_bufnr then
		    	vim.api.nvim_buf_set_var(current_bufnr,'command_ft',ft)
					vim.api.nvim_buf_set_var(current_bufnr, 'command_line_mode', line_mode)
		  	end
		   	-- 存储当前的模式
				local commands = require("easy-commands.impl");
				local allCommands = vim.tbl_deep_extend("keep", myCommands, commands);
				local names = {
        	"Glow"
				}
				for _, c in ipairs(allCommands) do
					table.insert(names, c.name)
				end

				vim.ui.select(names, {
					prompt = "Command Name: ",
			  	}, function(cmdName)
				  	if not cmdName or cmdName == "" then
					  	return
				  	end
				  	local editor = require("easy-commands.impl.util.editor")
				  	local string = require("easy-commands.impl.util.base.strings")
				  	vim.cmd(cmdName);
				  	-- vim.api.nvim_exec2("command " .. cmdName, { output = false })
	        	-- vim.api.nvim_exec2("wincmd o", { output = false })
				  	-- local content = string.splitIntoLines(result.output)
				  	-- editor.splitAndWrite(content, { vertical = true })
				end)
			end,
			description = "Inspect the commands that provided by easy-commands plugin",
		}
}
end

