local extendfiletype = function()
    vim.filetype.add({
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
        [".*/.*%.blade.php"] = 'html'
        -- ['%/.*/.*.balde.php'] = 'html'
      },
    });
end
return {
  extendfiletype = extendfiletype
}
