local combineCmds = require("user.commands.core").combineCmds;
return combineCmds({
  require('user.commands.snippet')
  ,{
    {
      name="DeleteFunction",
      callback = function ()
        pcall(require("user.commands.core").delete_current_function)
		  end
    }
  }
}
)
