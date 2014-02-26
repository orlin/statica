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
  gulp.src("harp/**/+(config|compass).rb", read: false)
    .pipe tap (config) ->
      project = path.dirname(config.path)
      gutil.log "Compass #{path.basename(config.path)} in #{project}"
      compile = ->
        exec "compass compile -c #{config.path}"
        , {cwd: project}
        , (error, stdout, stderr) ->
          console.log("[compass] compiling #{project}")
          process.stdout.write(stdout)
          console.log("[compass] error(s) above") if error isnt null
      compile()
      gulp.watch "#{project}/**/*.+(sass|scss)", (event) ->
        if event.type is "changed"
          compile()

gulp.task "livereload", ->
  reload = livereload()
  gulp.watch("harp/**").on "change", (file) ->
    reload.changed(file.path)

gulp.task "default", ["server", "compass", "livereload"]
