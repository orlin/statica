o = require("./options.coffee")

harp = require("harp")
pkgv = require("./node_modules/harp/package.json").version
port = o.harp.port

harp[o.harp.server] o.harp.path, port: port, ->
  console.log " Harp v#{pkgv} on http://localhost:#{port}"
