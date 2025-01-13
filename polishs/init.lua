return function()
    require "user.polishs.filetypes".extendfiletype()
    require "user.polishs.command"
    require "user.polishs.buffer".setup()
    -- require "user.polishs.findcode".setup()
    -- vim.cmd([[ au User LspNotify setup ]])
    -- Set up custom filetypes
end
