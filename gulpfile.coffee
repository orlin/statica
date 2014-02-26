gulp = require("gulp")
gutil = require("gulp-util")
nodemon = require("gulp-nodemon")
tap = require("gulp-tap")
path = require("path")
exec = require("child_process").exec
help = require("gulp-task-listing")
livereload = require("gulp-livereload")

# print = require("gulp-print") # debug


gulp.task "help", help

gulp.task "server", (next) ->
  nodemon
    verbose: false
    script: "server.coffee"
    watch: "server.coffee"
    env: { NODE_ENV: "development" }
  next()

gulp.task "compass", ->
  compile = (config, path) ->
    exec "compass compile -c #{config}", {cwd: path}, (error, stdout, stderr) ->
      console.log("[compass] compiling #{path}")
      process.stdout.write(stdout)
      console.log("[compass] error(s) above") if error isnt null
  gulp.src("harp/**/+(config|compass).rb", read: false)
    .pipe tap (configFile) ->
      configFull = configFile.path
      configPath = path.dirname(configFile.path)
      configName = path.basename(configFile.path)
      gutil.log "Compass config #{configName} for #{configPath}"
      compile(configFull, configPath)
      gulp.watch "#{configPath}/**/*.+(sass|scss)", (event) ->
        if event.type is "changed"
          compile(configFull, configPath)

gulp.task "default", ["server"], ->
  reload = livereload()
  gulp.watch("harp/**").on "change", (file) ->
    reload.changed(file.path)
