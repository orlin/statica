defaults =
  harp:
    mode: "multihost" # use "server" for a solo site
    path: "harp"
    port: 9000
    more: [] # "path" and "port" are required for each extra server
  compass:
    watch: ["{harp,sites,apps}/**/*.{sass,scss}", "!**/node_modules/**"]
    config: "{harp,sites,apps}/**/{config,compass}.rb"
    ensure: true # compile everything to be sure
  livereload:
    watch: ["{harp,sites,apps}/**/*.{jade,html,css,js,coffee}", "!**/node_modules/**"]
  gulp:
    default: ["server", "compass", "livereload"]

fs = require("fs")
merge = require("deepmerge")
optional = "./options.json"

if fs.existsSync(optional)
  module.exports = merge(defaults, require(optional))
else
  module.exports = defaults
