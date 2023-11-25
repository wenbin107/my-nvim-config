return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  version = "*",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-_>s",
        insert_line = "<C-_>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      }
    })
  end,
}
