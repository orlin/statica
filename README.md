# statica -- gulp harp

## WHY

[Harp](http://harpjs.com) is awesome.  However missing two things my workflow has grown accustomed to -- [Compass](http://compass-style.org) and livereload.  The former is expected [to be available](https://github.com/hcatlin/libsass/issues/82) *eventually* on top of [libsass](http://libsass.org)...  The original `sass` syntax (in addition to the current `scss`) [should arrive](https://github.com/sintaxi/harp/issues/185) sooner.  All this because of the yet incomplete feature parity between the Ruby and Node versions of Sass.  For now it simply makes more sense to compile styles with Ruby / Compass.  It appears livereload [will happen](https://github.com/sintaxi/harp/issues/80) as well.  I just couldn't wait for either.

[Gulp](http://gulpjs.com) automates the extra step of compiling to css and live-reloading any changes.


## LICENSE

This is free and unencumbered public domain software.
For more information, see [UNLICENSE](http://unlicense.org).
