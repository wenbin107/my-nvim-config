return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   dir = "/Users/wenbin/.config/nvim/lua/user/plugins/easy-commands.nvim",
  --   event = "VeryLazy",
  --   config = function()
	 --    -- local commands = require("easy-commands.impl")
  --     -- print(vim.inspect(commands));
	 --    -- require('lazy').setup(commands);
  --   end
  -- },
  -- {
  --   "LintaoAmons/easy-commands.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "BufRead",
    config = function()
    end,
  },
  {
    "Exafunction/codeium.vim",
    event = "BufRead",
    config = function()
      vim.keymap.set('i', '', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },
  {
    "Abstract-IDE/Abstract-cs"
  },
  {
    "ellisonleao/glow.nvim",
    event = "BufRead",
    cmd = "Glow",
    config = true
  },
  -- {
  --   "aarondiel/spread.nvim",
  --   event = "BufRead",
	 --  config = function()
		--   local spread = require("spread")
		--   local default_options = {
		-- 	  silent = true,
		-- 	  noremap = true
		--   }
		--   vim.keymap.add("n", "<leader>ss", spread.out, default_options)
		--   vim.keymap.add("n", "<leader>ssc", spread.combine, default_options)
	 --  end
  -- }
  -- {
  --   "SirVer/ultisnips",
  --   event = "BufRead",
  --   config = function()
  --     vim.g.UltiSnipsExpandTrigger = "<tab>"
  --     vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
  --     vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
  --     -- vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
  --     -- vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
  --   end
  -- },
  -- {
  --   "wenbin107/easy-commands.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- }
}
