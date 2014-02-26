defaults =
  harp:
    path: "harp"
    port: 9000
  compass:
    config: "harp/**/+(config|compass).rb"
  livereload:
    watch: "harp/**/*.+(jade|css)"
  gulp:
    default: ["server", "compass", "livereload"]

module.exports = defaults
