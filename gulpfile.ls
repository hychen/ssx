require! <[main-bower-files streamqueue]>
require! <[
  gulp
  gulp-bower
  gulp-concat
  gulp-filter
]>

# Config
# ----------------------------------
build_path = 'frontend/public'

# Main
# ----------------------------------
gulp.task 'bower', ->
  gulp-bower!

gulp.task "js:vendor", <[bower]>, ->
  bower = gulp.src main-bower-files!
    .pipe gulp-filter -> it.path is /\.js$/

  vendor = gulp.src <[
            frontend/vendor/js/jquery.dropotron.min.js
            frontend/vendor/js/config.js
            frontend/vendor/js/skel.min.js
            frontend/vendor/js/skel-panels.min.js
            ]>

  s = streamqueue { +objectMode }
    .done bower, vendor
    .pipe gulp-concat 'vendor.js'
    .pipe gulp.dest "#{build_path}/js"

gulp.task 'build', <[js:vendor]> 
gulp.task 'default', <[build]>
