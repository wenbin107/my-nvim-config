local file_url = os.getenv("HOME") .. "/.local/share/nvim/zhipu_key.txt";
local fo = io.open(file_url, "r");
local api_key
if fo ~= nil then
		local str = fo:read("*a");
		api_key = vim.fn.trim(str);
end
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
            secret = api_key
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
