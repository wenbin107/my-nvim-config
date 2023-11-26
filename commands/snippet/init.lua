local genTemp = require("user.commands.core.temp").genTemp;
local insertTemp = require("user.commands.core.temp").insertTemp;
local buffer = require('user.commands.core.buffer')
local mytable = require("user.commands.core.mytable");
return {
  insertTemp("InitReactFileContent",function ()
    return {
      "import React from \"React\";",
      "",
      "class NameComponent extends React.Component {",
      "  constructor(props) {",
      "    super(props);",
      "    this.state = {",
      "    }",
      "  }",
      "  componentDidMount () {",
      "      ",
      "  }",
      "  render(){",
      "    return (",
      "      <div>",
      "      </div>",
      "    )",
      "",
      "  }",
      "}",
      "",
      "export default NameComponent",
  }
  end
  ),
  insertTemp('InitFileContent',function (codes)
    local ft = vim.bo.ft;
    local replacement = {}
    local code_index = 0
    if ft == 'html' then
      replacement = {
        "<!DOCTYPE html>",
        "<html lang=\"en\">",
        "  <head>",
        "    <title></title>",
        "    <meta charset=\"UTF-8\">",
        "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">",
        "  </head>",
        "  <body>",
        "  ",
        "  </body>",
        "</html>",
      }
      code_index = 9
    elseif ft == 'vue' then
      replacement = {
        "<template>",
        "\t<view>",
        "",
        "\t</view>",
        "</template>",
        "<script>",
        "export default {",
        "\tonLoad(options){",
        "\t\tthis.options = options;",
        "\t\tthis.__initData();",
        "\t},",
        "\tmethods:{",
        "\t\t__initData(){",
        "",
        "\t\t}",
        "\t},",
        "",
        "\tdata() {",
        "\t\treturn {",
        "\t\toptions:null",
        "\t\t}",
        "\t}",
        "}",
        "</script>",
        "<style scoped lang=\"scss\">",
        "</style>"
      }
      code_index = 14
    end
    mytable.move(replacement,code_index,codes)
    return replacement
  end
  ),
  genTemp('AddLog',function ()
    local ft = vim.bo.ft;
    if ft == 'php' then
      return {
        "var_dump(",
        ");die;"
    }
    elseif ft == 'javascript' then
      return {'console.log(',');'}
    elseif ft == 'lua' then
      return {'print(',')'};
    end
    return {'console.log(',');'}
  end),
  insertTemp('InsertFunction',function(codes)
    local ft = vim.bo.ft;
    if not codes then
      codes = {"\t"}
    end
    local replacement = {};
    if ft == 'javascript'then
      replacement =  {
        "function name(){",
        "}"
      }
    elseif ft == 'php' then
      replacement  = {
        "\tpublic function name(){",
        "\t}"
      }
    else
      replacement = {
        "function name(){",
        "}"
      }
    end
    replacement = mytable.move(replacement,2,codes);
    return replacement;
  end),
  insertTemp('InsertLocalFunction',function(codes)
    if not codes then
      codes = {"\t"}
    end
    local replacement = {
      "let name = async () => {",
      "}"
    }
    replacement = mytable.move(replacement,2,codes);
    return replacement
  end),
  -- @types codes  string[]
  insertTemp('InsertclosureFunction',function(codes)
    if not codes then
      codes = {"\t"}
    end
    local replacement = { "(async () => {",
      "})()"
    }
    replacement = mytable.move(replacement,2,codes);
    return replacement
  end),
  {
		name = "AddSurround",
		callback = function ()
			local current_bufnr = vim.fn.bufnr('%')
			if not current_bufnr then
			  return
			end
			local ok,line_mode = pcall(vim.api.nvim_buf_get_var,current_bufnr, 'command_line_mode');
			local ok1,select_info = pcall(vim.api.nvim_buf_get_var,current_bufnr, 'command_select_info');
			if not select_info or not line_mode then
			  vim.notify("pleace first runcommand");
			  return
			else
			end
      vim.ui.input({
        prompt = "Surround with:",
      },function (s)
          if not s then
            return
          end
          local selections = select_info.selections;
          local selected_table = select_info.selected_table;
			    local replacement = {}
			    if #selected_table ~= 0 then
			      selected_table[1] = s..selected_table[1]
			      selected_table[#selected_table] = selected_table[#selected_table]..s
			      replacement = selected_table
			    else
			      replacement = {}
			    end
          buffer.change_selection(selections,replacement);
          -- 替换选中文本
        end)
		end
  },
}
