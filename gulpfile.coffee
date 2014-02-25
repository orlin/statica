gulp = require("gulp")
nodemon = require("gulp-nodemon")
exclude = require("gulp-ignore").exclude;
tap = require("gulp-tap")
path = require("path")
exec = require("gulp-exec")
gutil = require("gulp-util")
livereload = require("gulp-livereload")

# print = require("gulp-print") # debug

gulp.task "server", (next) ->
  nodemon
    verbose: false
    script: "server.coffee"
    watch: "server.coffee"
    env: { NODE_ENV: "development" }
  next()

gulp.task "compass", ->
  gulp.src(["harp/**/config.rb", "harp/**/compass.rb"], read: false)
    .pipe tap (configFile) ->
      configPath = path.dirname(configFile.path)
      configName = path.basename(configFile.path)
      gutil.log "Compass project #{configName} in #{configPath}"
      gulp.src(["#{configPath}/**/*.sass", "#{configPath}/**/*.scss"])
        .pipe exclude("**/_*")
        .pipe exec("cd #{configPath} && compass compile <%= file.path %>", silent: true)

gulp.task "default", ["server"], ->
  reload = livereload()
  gulp.watch("harp/**").on "change", (file) ->
    reload.changed(file.path)
