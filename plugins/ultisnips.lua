return {
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "plugins.configs.luasnip"(plugin, opts)
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.loop.os_homedir().."/.config/nvim/lua/user/snippets"
        }
      })
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      -- luasnip.filetype_extend("javascript", { "javascriptreact" })
      -- luasnip.filetype_extend("html", { "blade" })
    end,
  },
}
