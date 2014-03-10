defaults =
  harp:
    server: "multihost" # use "server" for a solo site
    path: "harp"
    port: 9000
  compass:
    watch: "{harp,sites}/**/*.{sass,scss}"
    config: "{harp,sites}/**/{config,compass}.rb"
  livereload:
    watch: "{harp,sites}/**/*.{jade,html,css}"
  gulp:
    default: ["server", "compass", "livereload"]

fs = require("fs")
merge = require("deepmerge")
optional = "./options.json"

if fs.existsSync(optional)
  module.exports = merge(defaults, require(optional))
else
  module.exports = defaults
