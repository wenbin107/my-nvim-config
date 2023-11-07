local extendfiletype = function()
    vim.filetype.add {
      extension = {
        foo = "fooscript",
        wxml = "html",
        wxss = "css",
      },
      filename = {
        ["Foofile"] = "fooscript",
      },
      pattern = {
        ["~/%.config/foo/.*"] = "fooscript",
      },
    };
end
return {
  extendfiletype = extendfiletype
}
