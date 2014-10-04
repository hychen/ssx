require! <[main-bower-files streamqueue]>
require! <[
  gulp
  gulp-bower
  gulp-concat
  gulp-filter
]>

# Config
# ----------------------------------
build_path = 'public'

# Main
# ----------------------------------
gulp.task 'bower', ->
  gulp-bower!

gulp.task "js:vendor", <[bower]>, ->
  bower = gulp.src main-bower-files!
    .pipe gulp-filter -> it.path is /\.js$/

  vendor = gulp.src <[
            vendor/js/jquery.dropotron.min.js
            vendor/js/config.js
            vendor/js/skel.min.js
            vendor/js/skel-panels.min.js
            ]>

  s = streamqueue { +objectMode }
    .done bower, vendor
    .pipe gulp-concat 'vendor.js'
    .pipe gulp.dest "#{build_path}/js"    

gulp.task 'build', <[js:vendor]>
gulp.task 'default', <[build]>	