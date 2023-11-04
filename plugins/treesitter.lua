return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      -- "lua"
      "vue",
    });
    opts.highlight = {
      enable = true,
      additional_vim_regex_highlighting=true,
      matchers = {
        'tree_sitter#parser#isVueScript',
      }
    };
    opts.incremental_selection = {
      enable = true
    };
    opts.contextual_parser = {
      enable = true
    };
    opts.indent = { enable = true };
    opts.autotag = { enable = true };
  end,
}
