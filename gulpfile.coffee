gulp    = require "gulp"
coffee  = require "gulp-coffee"
clean   = require "gulp-clean"
jade    = require "gulp-jade"
bower   = require "gulp-bower-files"
connect = require "gulp-connect-multi"
connect = connect()

gulp.task "jade", ->
  gulp.src "src/jade/*.jade"
    .pipe jade()
    .pipe gulp.dest "dst/"

gulp.task "coffee", ->
  gulp.src "src/coffee/*.coffee"
    .pipe coffee()
    .pipe gulp.dest "dst/js"

gulp.task "bower", ->
  bower()
    .pipe gulp.dest "dst/lib/"

gulp.task "clean", ->
  gulp.src "dst"
    .pipe clean()

gulp.task "connect", connect.server({
    root: ["dst/"]
    port: 3939
    livereload: true
    open:
      browser: "Google Chrome"
  })

gulp.task "watch", ->
  gulp.watch "src/jade/**", ["jade"]
  gulp.watch "src/coffee/**", ["coffee"]

# Default task
gulp.task "default", ["clean", "bower", "coffee", "jade", "connect", "watch"]