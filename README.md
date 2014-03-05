# statica -- gulp harp

## WHY

[Harp](http://harpjs.com) is awesome.  Only missing two things my workflow has grown accustomed to -- [Compass](http://compass-style.org) and livereload.  The former [would be available](https://github.com/hcatlin/libsass/issues/82) *eventually* on top of [libsass](http://libsass.org)...  The original `sass` syntax [could arrive](https://github.com/sintaxi/harp/issues/185) perhaps sooner.  All this because of the yet incomplete feature parity between the Ruby and Node versions of Sass.  For now it simply makes more sense to compile styles with Ruby / Compass.  It appears livereload [will happen](https://github.com/sintaxi/harp/issues/80) as well.  I just couldn't wait for either.

[Gulp](http://gulpjs.com) automates the extra step of compiling to css and live-reloading any changes.  Building sites for static deployment is another possible use.  Have a look at its [plugins](http://gulpjs.com/plugins) for ideas.


## USE

Clone or fork the project and `npm install` its node modules.  Harp projects are served by default in multihost mode from a git-ignored `harp` directory, any of which may of-course be git repositories themselves.  The defaults coming from `options.coffee` can be overridden with an `options.json`.  For example, to change the `harp` projects directory to `sites` create an options.json with contents of `{"harp": {"path": "sites"}}` -- in such a case, also add `sites` to the `.gitignore`.

Start the default tasks (harp `server`, `compass` and `livereload`) using either `npm run server` or after `npm install -g gulp` just with the `gulp` command.

Compass projects are identified through the presence of their `config.rb` (or `compass.rb`) files.  Exact `compass.config` paths can optionally be supplied.  Configure what is watched and reloaded with `livereload.watch`.  It's the configuration value most likely to vary between projects.  If a single [minimatch](https://github.com/isaacs/minimatch) glob pattern isn't good-enough, gulp can take an array of strings too.

Override the `gulp.default` to run extra tasks, skip `compass`, etc.

Happy gulp-harping!


## LICENSE

This is free and unencumbered public domain software.
For more information, see [UNLICENSE](http://unlicense.org).
