gulp = require("gulp")
nodemon = require("gulp-nodemon")
livereload = require("gulp-livereload")

gulp.task "server", (next) ->
  nodemon
    verbose: false
    script: "server.coffee"
    watch: "server.coffee"
    env: { NODE_ENV: "development" }
  next()

gulp.task "default", ["server"], ->
  reload = livereload()
  gulp.watch("harp/**").on "change", (file) ->
    reload.changed(file.path)
