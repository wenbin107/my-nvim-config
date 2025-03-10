 -- vim合并table
 local RunCommands = require("user.commands.RunCommad")
 local combineCmds = require("user.commands.core").combineCmds;
 local myCommands = {
  { name = "ToggleOutline", callback = "AerialNavToggle" },
  { name = "CodeActions", callback = "lspsaga code_actions" },
  {
    name = "DeleteEmptyLines",
    callback = "g/^$/d",
    description = "Delete empty lines in the current file",
  },
  {
    name = "RunCode",
    callback = function ()
			 local editor = require("easy-commands.impl.util.editor")
			 local string = require("easy-commands.impl.util.base.strings")
			 local ft = vim.bo.ft;
			 local cmdName = '!node';
			 if(ft == 'javascript') then
         cmdName = '!node'
       elseif(ft == 'lua') then
         cmdName = 'luafile'
			 end
			 local result = vim.api.nvim_exec2("" .. cmdName .." %", { output = true })
			 if not result then
			   return
			 end
			 local content = string.splitIntoLines(result.output)
			 editor.splitAndWrite(content, { vertical = true })
	     -- vim.api.nvim_exec2("wincmd o", { output = false })
			 -- local content = string.splitIntoLines(result.output)
			 -- editor.splitAndWrite(content, { vertical = true })
    end,
    description = "run code split window",
  },
  {
    name = "HurlSelected",
    callback = function()
      local sys = require("easy-commands.impl.util.base.sys")
      local editor = require("easy-commands.impl.util.editor")
      local content = editor.getSelectedText()
      local tmpFile = write_to_temp_file(content)
      local stdout, _, stderr = sys.run_os_cmd({ "hurl", "--verbose", tmpFile }, ".")
      local result = stdout or stderr
      editor.splitAndWrite(result, { vertical = true })
    end,
    description = "use `hurl` to run current buffer and output to splitted window",
    allow_visual_mode = true,
  },
  {
    name = "Hurl",
    callback = function()
      local sys = require("easy-commands.impl.util.base.sys")
      local editor = require("easy-commands.impl.util.editor")
      local bufferAbsPath = editor.get_buf_abs_path()
      local stdout, _, stderr = sys.run_os_cmd({ "hurl", "--verbose", bufferAbsPath }, ".")
      local result = stdout or stderr
      editor.splitAndWrite(result, { vertical = true })
    end,
    description = "use `hurl` to run current buffer and output to splitted window",
  },
  {
    name = "ToggleDiagramMode",
    callback = function()
      append_empty_lines()
      local venn_enabled = vim.inspect(vim.b.venn_enabled)
      if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd([[setlocal ve=all]])
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
      else
        vim.cmd([[setlocal ve=]])
        vim.cmd([[mapclear <buffer>]])
        vim.b.venn_enabled = nil
      end
    end,
    description = "Toggle diagram mode and attach shortcuts to current buffer",
  },
  {
    name = "DistinctLines",
    callback = "sort u",
  },
  {
    name = "TrimLine",
    callback = function()
      local line = vim.api.nvim_get_current_line()
      local trimmed = string.match(line, "^%s*(.-)%s*$")
      vim.api.nvim_set_current_line(trimmed)
    end,
  },
  {
    name = "JoinLines",
    callback = "'<,'>s/\v\n/,/",
  },
  {
    name = "TempKeymap",
    callback = function()
      vim.ui.input({ prompt = "write your temp keymap, like: . @q" }, function(msg)
        vim.print("map <buffer> " .. msg)
        vim.api.nvim_command("map <buffer> " .. msg)
      end)
    end,
    description = "Create a buffer local keymap for tmp use",
  },
  {
    name = "GitAmend",
    callback = "G commit --amend",
    dependencies = { "tpope/vim-fugitive" },
  },
  {
    name = "GotoFunctionName",
    callback = "AerialPrev",
    dependencies = { "https://github.com/stevearc/aerial.nvim" },
  },
  {
    name = "ToggleOutline",
    callback = "AerialToggle",
    dependencies = { "https://github.com/stevearc/aerial.nvim" },
   },
 }
 local mixCommands = combineCmds({
   myCommands,
   require("user.commands.func")
 });
 return vim.tbl_deep_extend("force",mixCommands,RunCommands(mixCommands))
