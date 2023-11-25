local genTemp = require("user.commands.core.temp").genTemp;
local insertTemp = require("user.commands.core.temp").insertTemp;
return {
  genTemp('AddLog','console.log(',');'),
  insertTemp('InsertFunction',{
    "function name(){",
    "",
    "}"
  }),
  insertTemp('InsertLocalFunction',{
    "let name = async () => {",
    "}"
  }),
  insertTemp('InsertclosureFunction',{
    "(async () => {",
    "",
    "})()"
  }),
  {
		name = "AddSurround",
		callback = function ()
			local current_bufnr = vim.fn.bufnr('%')
			if not current_bufnr then
			  return
			end
			local ok,line_mode = pcall(vim.api.nvim_buf_get_var,current_bufnr, 'command_line_mode');
			local ok1,select_info = pcall(vim.api.nvim_buf_get_var,current_bufnr, 'command_select_info');
			if not select_info or not line_mod then
			  vim.notify("pleace first runcommand");
			  return
			else
			  -- vim.print(select_info);
			end
		  -- local select_info = get_select_info();
		  -- restore_section(stored_selection);
		  -- if line_mode == 'v' then
		  --   vim.cmd("normal c"..select_info.selected_text.."++++++")
		  -- local selected_text = vim.fn.getline(stored_selection.start_line, stored_selection.end_line)
      --   table.insert(selected_text, "")
      vim.ui.input({
        prompt = "Surround with:",
      },function (s)
          if not s then
            return
          end
          -- 替换选中文本
          vim.api.nvim_buf_set_text(current_bufnr, select_info.start_line - 1, select_info.start_col - 1, select_info.end_line - 1, select_info.end_col,{s..select_info.selected_text..s}) -- end
        end)
		end
  },
  {
    name="DeleteFunction",
    callback = function ()
       pcall(require("user.commands.core").delete_current_function)
		end
  }
}
