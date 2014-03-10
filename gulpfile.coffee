o = require("./options.coffee")
glob = require("glob")
gulp = require("gulp")
require("gulp-load")(gulp)
gutil = require("gulp-util")
nodemon = require("gulp-nodemon")
path = require("path")
exec = require("child_process").exec
help = require("gulp-task-listing")
livereload = require("gulp-livereload")
fs = require("fs")
rimraf = require("rimraf")
# print = require("gulp-print") # debug


# load private ./tasks/*.js
gulp.loadTasks __dirname


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
    compile = (config, file) ->
      root = path.dirname(config)
      # NOTE: skipped tracking sass import dependencies...
      # Thus, compile the whole project if a given file is _{underscored} for @import.
      # Next, https://github.com/lox/sass-graph could help with optimizing it further.
      file = "" if typeof(file) isnt "string" or path.basename(file).indexOf("_") is 0
      exec "compass compile -c #{config} #{file}"
      , {cwd: root}
      , (error, stdout, stderr) ->
        console.log("[compass] compiling #{root}")
        process.stdout.write(stdout)
        process.stdout.write(stderr) if stderr
        console.log("[compass] error(s) above") if error isnt null

    # Precompile all compass projects just in case anything has changed.
    if o.compass.ensure is true
      for conf in configs
        gutil.log("Compass #{path.basename(conf)} in #{path.dirname(conf)}")
        compile(conf)

    gulp.watch o.compass.watch, (event) ->
      unless event.type is "deleted" # if added or changed
        for conf in configs
          if event.path.indexOf(path.dirname(conf)) is 0
            compile(conf, event.path)
            break
      else
        console.log("[deleted] #{event.path}")
        # make a guess that the css is written to the same directory
        name = path.basename(event.path).replace(/\.[^\.]+$/, ".css")
        file = path.join(path.dirname(event.path), name)
        fs.exists file, (exists) ->
          if exists
            rimraf file, (err) ->
              if err is null
                console.log("[deleted] #{file}")
              else
                console.log(err)
          else
            console.log("Note: unhandled deletion of #{event.path}")


gulp.task "livereload", ->
  reload = livereload()
  gulp.watch o.livereload.watch, (event) ->
    console.log "[watched] #{path.basename(event.path)} has been #{event.type}"
    # NOTE: unsure if it makes sense to live-reload on added or deleted files
    reload.changed(event.path)


gulp.task "default", o.gulp.default
