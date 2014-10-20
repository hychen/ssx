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
  build = (name, files) ->
    src = gulp.src files
    s = streamqueue { +objectMode }
      .done src
      .pipe gulp.dest "#{build_path}/#{name}"      

  build 'vendor/jquery/js', <[
    bower_components/jquery/dist/jquery*
    ]>            

  build 'vendor/moment/js', <[
    bower_components/moment/min/moment.min.js
    ]>      

  build 'vendor/fullcalendar/js', <[
    bower_components/fullcalendar/dist/fullcalendar.min.js
    bower_components/fullcalendar/dist/lang/zh-tw.js
    ]>

  build 'vendor/fullcalendar/css', <[
    bower_components/fullcalendar/dist/fullcalendar.min.css
    bower_components/fullcalendar/dist/fullcalendar.print.css
    ]>

  build 'vendor/react/js', <[
    bower_components/react/react.min.js
    bower_components/reactfire/dist/reactfire.min.js
    ]>

  build 'vendor/firebase/js', <[
    bower_components/firebase/firebase.js
    ]>

gulp.task 'build', <[js:vendor js:app]>
gulp.task 'default', <[build]>

gulp.task 'watch', <[build]>, ->
  gulp-livereload.listen silent: true
  gulp.watch "frontend/app/*.ls", <[js:app]> .on \change, gulp-livereload.changed
