bower    = require 'bower'
flatten  = require 'gulp-flatten'
gulp     = require 'gulp'
prefixer = require 'gulp-autoprefixer'
clean    = require 'gulp-clean'
coffee   = require 'gulp-coffee'
concat   = require 'gulp-concat'
connect  = require 'gulp-connect'
jade     = require 'gulp-jade'
mincss   = require 'gulp-minify-css'
plumber  = require 'gulp-plumber'
sass     = require 'gulp-ruby-sass'
sequence = require 'run-sequence'

gulp.task 'jade', ->
  gulp.src ['src/jade/**/*.jade', '!src/jade/layout/**', '!src/jade/template/**']
    .pipe plumber()
    .pipe flatten()
    .pipe jade()
    .pipe gulp.dest 'dst/'

gulp.task 'coffee', ->
  gulp.src 'src/coffee/*.coffee'
    .pipe plumber()
    .pipe coffee()
    .pipe gulp.dest 'dst/js/'

gulp.task 'sass', ->
  gulp.src 'src/sass/*.sass'
    .pipe plumber()
    .pipe concat 'style.sass'
    .pipe sass()
    .pipe prefixer 'last 3 version'
    .pipe mincss()
    .pipe gulp.dest 'dst/css/'

gulp.task 'copy', ->
  gulp.src 'src/image/**', {base: 'src/image'}
    .pipe gulp.dest 'dst/image/'

gulp.task 'bower', ->
  bower.commands.install().on 'end', (installed) ->
    gulp.src [
      'bower_components/bootstrap/dist/css/bootstrap.min.css'
      'bower_components/bootstrap/dist/css/bootstrap.css.map'
      'bower_components/bootstrap/dist/js/bootstrap.min.js'
      'bower_components/bootstrap/dist/fonts/*'
    ]
      .pipe gulp.dest('./dst/lib/bootstrap/')

    gulp.src [
      'bower_components/jquery/dist/jquery.min.js'
      'bower_components/jquery/dist/jquery.min.map'
    ]
      .pipe gulp.dest('./dst/lib/jquery/')

    gulp.src [
      'bower_components/lightbox2/css/lightbox.css'
    ]
      .pipe gulp.dest('./dst/lib/lightbox2/css')

    gulp.src [
      'bower_components/lightbox2/js/lightbox.min.js'
      'bower_components/lightbox2/js/lightbox.min.map'
    ]
      .pipe gulp.dest('./dst/lib/lightbox2/js')

    gulp.src [
      'bower_components/lightbox2/img/close.png'
      'bower_components/lightbox2/img/next.png'
      'bower_components/lightbox2/img/prev.png'
      'bower_components/lightbox2/img/loading.gif'
    ]
      .pipe gulp.dest('./dst/lib/lightbox2/img')

gulp.task 'clean', ->
  gulp.src 'dst'
    .pipe clean()

gulp.task 'connect', ->
  connect.server
    root: ['dst']
    port: 3939
    livereload: true
    base: 'dst'

gulp.task 'watch', ->
  gulp.watch 'src/jade/**', ['jade']
  gulp.watch 'src/coffee/**', ['coffee']
  gulp.watch 'src/sass/**', ['sass']
  gulp.watch 'src/image/**', ['copy']
  gulp.watch 'src/**', ['livereload']

gulp.task 'livereload', ->
  gulp.src ''
    .pipe connect.reload()

## Tasks
# Build Task
gulp.task 'build', ['clean'], -> 
  sequence ['bower', 'copy', 'sass', 'coffee', 'jade']

# Server Task
gulp.task 'server', ->
  sequence ['build'], 'watch', 'connect'