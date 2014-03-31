require! <[gulp gulp-util express connect-livereload gulp-jade tiny-lr gulp-livereload path gulp-livescript gulp-less]>

app = express!
lr = tiny-lr!

build_path = '_public'

gulp.task 'html', ->
  gulp.src 'app/**/*.jade'
    .pipe gulp-jade!
    .pipe gulp.dest "#build_path"
    .pipe gulp-livereload lr

gulp.task 'js', ->
  gulp.src 'app/**/*.ls'
    .pipe gulp-livescript!
    .pipe gulp.dest "#build_path"
    .pipe gulp-livereload lr

gulp.task 'css', ->
  gulp.src 'app/less_proxy.less'
    .pipe gulp-less!
    .pipe gulp.dest "#build_path"
    .pipe gulp-livereload lr

gulp.task 'assets', ->
  gulp.src 'app/assets'
    .pipe gulp.dest "#build_path"
    .pipe gulp-livereload lr

gulp.task 'server', ->
  app.use connect-livereload!
  app.use express.static path.resolve "#build_path"
  app.listen 3000
  gulp-util.log 'Listening on port 3000'

gulp.task 'watch', ->
  lr.listen 35729, ->
    return gulp-util.log it if it
  gulp.watch 'src/**/*.jade', <[html]>
  gulp.watch 'src/**/*.png', <[assets]>
  gulp.watch 'src/**/*.sass', <[css]>
  gulp.watch 'src/**/*.ls', <[js]>

gulp.task 'build', <[html js assets css]>
gulp.task 'dev', <[build server watch]>
gulp.task 'default', <[build]>