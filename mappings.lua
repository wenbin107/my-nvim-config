local utils = require "astronvim.utils"
-- local surround = require "user.polishs.surround"
-- surround.surround()
-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>ml"] = { desc = "less to css to current file",
      "<cmd>!lessc --compress %:p > %:p:h/%:t:r.css<cr><space>"
    },
    ["<leader>mw"] = { desc = "less to wxss to current file",
      "<cmd>!lessc --compress %:p > %:p:h/%:t:r.wxss<cr><space>"
    },
    ["<leader>fT"] = { desc = "find filetypes",
      "<cmd>Telescope filetypes<cr>"
    },
    ["<leader>mr"] = { desc = "run server in current file",
      function()
        utils.toggle_term_cmd "npx http-serve ./ -o" end;
    },
    ["<leader>rn"] = { desc = "run node current file",
      "<cmd>!node %<cr>"
    },

    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  v = {
    -- ['<leader>s{'] = { function()
    --   -- vim.api.nvim_exec('c '..surround.surround())
    --   end
    --   , desc = 'Surround with {'}
  }, 
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
