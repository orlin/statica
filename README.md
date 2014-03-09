# statica -- gulp harp

## WHY

[Harp](http://harpjs.com) is awesome.  Only missing two things my workflow has grown accustomed to -- [Compass](http://compass-style.org) and livereload.  The former [would be available](https://github.com/hcatlin/libsass/issues/82) *eventually* on top of [libsass](http://libsass.org)...  The original `sass` syntax [could arrive](https://github.com/sintaxi/harp/issues/185) perhaps sooner.  All this because of the yet incomplete feature parity between the Ruby and Node versions of Sass.  For now it simply makes more sense to compile styles with Ruby / Compass.  It appears livereload [will happen](https://github.com/sintaxi/harp/issues/80) as well.  I just couldn't wait for either.

[Gulp](http://gulpjs.com) automates the extra step of compiling to css and live-reloading any changes.  Building sites for static deployment is another possible use.  Have a look at its [plugins](http://gulpjs.com/plugins) for ideas.

Statica can also help with development of any web apps, beyond the static / Harp-served.  The `compass` and `livereload` tasks would be just as applicable to any webdev workflow.  As for the `server`, given `node` apps, [Katon](https://github.com/typicode/katon) is simply fantastic.


## USE

### Setup

Clone or fork the project and `npm install` its node modules.  Harp projects are served by default in multihost mode from a git-ignored `harp` directory, any of which may of-course be git repositories themselves.  The defaults coming from `options.coffee` can be overridden with an `options.json`.  For example, to change the `harp` projects directory to `sites` create an options.json with contents of `{"harp": {"path": "sites"}}`.  It's where I actually keep my non-harp sites, so that directory is already git-ignored and watched by default.

Start the default tasks (harp `server`, `compass` and `livereload`) using either `npm run server` or after `npm install -g gulp` just with the `gulp` command.

Compass projects are identified through the presence of their `config.rb` (or `compass.rb`) files.  Exact `compass.config` paths can optionally be supplied.  Configure what is watched and reloaded with `livereload.watch`.  It's the configuration value most likely to vary between projects.  If a single [minimatch](https://github.com/isaacs/minimatch) glob pattern isn't good-enough, gulp can take an array of strings, possibly excluding paths too.

Override the `gulp.default` to run extra tasks, skip `compass`, etc.

### Private Tasks

If you need some custom tasks that aren't meant for sharing, make a `tasks` directory and put the code in it.  Using [gulp-load](https://github.com/popomore/gulp-load) which looks for `./tasks/*.js`.  Here is an example test task:

```js
module.exports = function(gulp) {
  gulp.task("test", function() {
    console.log("console-logged: 'test'");
  });
};
```

Run it with `gulp test`, add it to the `gulp.default`, etc.


Happy gulp-harping!


## LICENSE

This is free and unencumbered public domain software.
For more information, see [UNLICENSE](http://unlicense.org).
