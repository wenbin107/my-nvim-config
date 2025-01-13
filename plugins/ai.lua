return {
  {
    -- dir = "../gp.nvim",
    dir = vim.loop.os_homedir() .. "/.config/nvim/lua/user/gp.nvim",
    event = "BufRead",
    config = function()
      local conf = {
        providers = {
          zhipu = {
            endpoint = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
            secret = "b5102e32dfef8cda86fae1e1f7d1e19b.7N0ol6a0tcciBxaM",
          },
        },
        agents = {
          {
            name = "ChatGPT3-5",
            disable = true,
          },
          {
            name = "zhipu",
            provider = "zhipu",
            chat = true,
            stream = true,
            command = true,
            model = { model = "glm-4-flash" },
            system_prompt = "",
          },
        },
        -- For customization, refer to Install > Configuration in the Documentation/Readme
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
}
