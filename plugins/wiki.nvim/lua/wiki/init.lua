local M = {}
local wiki = {}
M.setup = function(user_opts)
  wiki = vim.tbl_deep_extend("force",{
    -- path = vim.fn.stdpath("data") .. "/wiki"
    path = vim.loop.os_homedir() .. "/wiki/",
    wiki = '<leader>rw',
    wiki_file = '<cr>'
  })
end
return M
