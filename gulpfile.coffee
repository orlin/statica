gulp = require "gulp"
nodemon = require "gulp-nodemon"

gulp.task "default", ->
  nodemon
    verbose: false
    script: "server.coffee"
    watch: "server.coffee"
    env: { NODE_ENV: "development" }
