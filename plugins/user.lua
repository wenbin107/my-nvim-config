return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
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
  --   "wenbin107/easy-commands.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- }
}
