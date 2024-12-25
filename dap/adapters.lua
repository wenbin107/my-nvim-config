return {
 ["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
   command = "node",
   -- 💀 Make sure to update this path to point to your installation
   args = { os.getenv "HOME" .. "/js-debug/dist/dapDebugServer.js", "${port}"},
  }
 }
}
