local M = {};

function M.setup()
  vim.keymap.set(
    {
      "n",
      "v",
    },
    "<leader>bss",
    M.buffers,
    {
      desc = "quick picker buffer by select",
    }
  )
end


function M.buffers()
  local buffers = vim.api.nvim_list_bufs();
  local selects = {
      
  };
  local options = {
      
  };
  for i, v in ipairs(buffers) do
      local name = vim.api.nvim_buf_get_name(v);
      if name ~= '' then
        name = name.gsub(name,"(%w+/).+/","");
        table.insert(options, name);
        selects[name] = v;
      end
      -- selects[i] = { name, v };
      -- vim.notify(name);
  end

  vim.ui.select(options, { prompt = "select buffer" }, function(choice)
      if choice then
          vim.api.nvim_set_current_buf(selects[choice]);
      end
  end)
end





return M;
