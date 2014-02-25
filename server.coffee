port = 9000
pkgv = require("./node_modules/harp/package.json").version
harp = require "harp"
harp.multihost "harp", port: port, ->
  console.log " Harp v#{pkgv} on http://localhost:#{port}"
