o = require("./options.coffee")

harp = require("harp")
pkgv = require("./node_modules/harp/package.json").version
port = o.harp.port

harps = (path, port, mode = "server") ->
  harp[mode] path, port: port, ->
    console.log " Harp v#{pkgv} on http://localhost:#{port}"

# start at least one server, or multihost some path (multihost is the default mode)
harps(o.harp.path, o.harp.port, o.harp.mode)
# start more servers from other paths (on more ports)
for harper in o.harp.more
  harps(harper.path, harper.port)
