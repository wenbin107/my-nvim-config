return function()
    require "user.polishs.filetypes".extendfiletype()
    require "user.polishs.command"
    require "user.polishs.buffer".setup()
    local openai = require('user.polishs.openai');
    openai.setup({})
    vim.keymap.set('v', '<C-g>r', openai.replace, {
      silent = true,
      noremap = true,
      desc = "[G]pt [R]ewrite"
    })
    vim.keymap.set('v', '<C-g>p', openai.visual_prompt, {
      silent = false,
      noremap = true,
      desc = "[G]pt [P]rompt"
    })
    vim.keymap.set('n', '<C-g>p', openai.prompt, {
      silent = true,
      noremap = true,
      desc = "[G]pt [P]rompt"
    })
    vim.keymap.set('n', '<C-g>c', openai.cancel, {
      silent = true,
      noremap = true,
      desc = "[G]pt [C]ancel"
    })
    vim.keymap.set('i', '<C-g>p', openai.prompt, {
      silent = true,
      noremap = true,
      desc = "[G]pt [P]rompt"
    })
end
