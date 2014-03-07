o = require("./options.coffee")
glob = require("glob")
gulp = require("gulp")
gutil = require("gulp-util")
nodemon = require("gulp-nodemon")
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
  glob o.compass.config, { sync: true, nonull: false }, (e, files) ->
    configs = for file in files then path.resolve(__dirname, file)
    compile = (config) ->
      root = path.dirname(config)
      exec "compass compile -c #{config}"
      , {cwd: root}
      , (error, stdout, stderr) ->
        console.log("[compass] compiling #{root}")
        process.stdout.write(stdout)
        console.log("[compass] error(s) above") if error isnt null

    for conf in configs
      gutil.log("Compass #{path.basename(conf)} in #{path.dirname(conf)}")
      compile(conf)

    gulp.watch "#{o.harp.path}/**/*.{sass,scss}", (event) ->
      unless event.type is "deleted" # if added or changed
        for conf in configs
          if event.path.indexOf(path.dirname(conf)) is 0
            compile(conf)
            break
      else console.log("Note: unhandled deletion of #{event.path}")


gulp.task "livereload", ->
  reload = livereload()
  gulp.watch o.livereload.watch, (event) ->
    gutil.log "#{path.basename(event.path)} has been #{event.type}"
    reload.changed(event.path)


gulp.task "default", o.gulp.default
