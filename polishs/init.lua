return function()
    require "user.polishs.filetypes".extendfiletype()
    require "user.polishs.command"
    require "user.polishs.dap"
    -- vim.cmd([[ au User LspNotify setup ]])
    -- Set up custom filetypes
end
