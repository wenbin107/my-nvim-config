return {
 {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        outline = {
          auto_preview = false,
        },
      })
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
}
