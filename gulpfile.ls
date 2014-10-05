require! <[main-bower-files streamqueue]>
require! <[
  gulp
  gulp-bower
  gulp-concat
  gulp-filter
  gulp-plumber
  gulp-livescript
  gulp-livereload
  gulp-util
]>

# Config
# ----------------------------------
build_path = 'frontend/public'

# Main
# ----------------------------------
gulp.task 'bower', ->
  gulp-bower!

gulp.task "js:app", ->
  app = gulp.src 'frontend/app/*.ls'
    .pipe gulp-plumber!
    .pipe gulp-livescript({+bare}).on 'error', gulp-util.log

  streamqueue { +objectMode }
    .done app
    .pipe gulp.dest "#{build_path}/js"

gulp.task "js:vendor", <[bower]>, ->
  bower = gulp.src main-bower-files!
    .pipe gulp-filter -> it.path is /\.js$/

  vendor = gulp.src <[
            frontend/vendor/js/jquery.dropotron.min.js
            frontend/vendor/js/config.js
            frontend/vendor/js/skel.min.js
            frontend/vendor/js/skel-panels.min.js
            bower_components/prelude-ls/browser/prelude-browser-min.js
            ]>

  s = streamqueue { +objectMode }
    .done bower, vendor
    .pipe gulp-concat 'vendor.js'
    .pipe gulp.dest "#{build_path}/js"

gulp.task 'build', <[js:vendor js:app]>
gulp.task 'default', <[build]>

gulp.task 'watch', <[build]>, ->
  gulp-livereload.listen silent: true
  gulp.watch "frontend/app/*.ls", <[js:app]> .on \change, gulp-livereload.changed