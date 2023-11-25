-- print table 
-- print(vim.inspect(require("user.commands.myCommands"))require("user.commands.myCommands"))
return {
      disabledCommands = { "Git" }, -- You can disable the commands you don't want
      -- It always welcome to send me back your good commands and usecases
      ---@type EasyCommand.Command[]
      myCommands = require("user.commands.myCommands"),
      aliases = {
        {
          from = "DebugStart",
          to = "DebugContinue",
        },
        {
          from = "GitListCommits",
          to = "GitLog",
        },
      },
    }
