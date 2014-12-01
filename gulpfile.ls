require! <[gulp gulp-util express connect-livereload gulp-jade gulp-livereload path]>
require! <[gulp-if gulp-livescript gulp-less gulp-concat gulp-json-editor gulp-commonjs gulp-insert streamqueue gulp-uglify gulp-open gulp-plumber gulp-rename]>

gutil = gulp-util

app = express!

build_path = '_public'
production = true if gutil.env.env is \production

gulp.task 'translations' ->
  require! <[fs]>
  fs.readdir './md', (,langs)->
    for lang in langs
      real-lang = lang.replace /(\w+-)(\w+)/, (,$1,$2) -> $1+$2.toUpperCase!

      gulp.src 'app/partials/*.jade'
        .pipe gulp-jade do
          locals:
            lang: real-lang
        .pipe gulp.dest "#{build_path}/#{real-lang}"

  gulp.src \app/assets/translations/*.json.ls
    .pipe gulp-if !production, gulp-plumber errorHandler: (error) ->
      gutil.log gutil.colors.red error.message
    .pipe gulp-livescript {+bare}
    .pipe gulp.dest "#{build_path}/translations"

gulp.task 'html', <[translations]>, ->
  gulp.src 'app/*.jade'
    .pipe gulp-if !production, gulp-plumber!
    .pipe gulp-jade!
    .pipe gulp.dest "#{build_path}"

require! <[gulp-bower main-bower-files gulp-filter]>

gulp.task 'bower' ->
  gulp-bower!

gulp.task 'js:vendor' <[bower]> ->
  bower = gulp.src main-bower-files!
    .pipe gulp-filter -> it.path is /\.js$/

  vendor = gulp.src 'vendor/scripts/*.js'

  s = streamqueue { +objectMode }
    .done bower, vendor
    .pipe gulp-concat 'vendor.js'
    .pipe gulp-if production, gulp-uglify!
    .pipe gulp.dest "#{build_path}/js"

gulp.task 'js:app', ->
  env = gulp.src 'app/**/*.jsenv'
    .pipe gulp-json-editor (json) ->
      for key of json when process.env[key]?
        json[key] = that
      json
    .pipe gulp-insert.prepend 'module.exports = '
    .pipe gulp-commonjs!

  app = gulp.src [
    'app/**/*.ls'
    '!app/**/*.json.ls'
    ]
    .pipe gulp-if !production, gulp-plumber errorHandler: (error) ->
      gutil.log gutil.colors.red error.message
    .pipe gulp-livescript({+bare})

  streamqueue { +objectMode }
    .done env, app
    .pipe gulp-concat 'app.js'
    .pipe gulp-if production, gulp-uglify!
    .pipe gulp.dest "#{build_path}/js"

gulp.task 'css', ->
  compress = production
  gulp.src 'app/styles/app.less'
    .pipe gulp-if !production, gulp-plumber!
    .pipe gulp-less compress: compress
    .pipe gulp.dest "#{build_path}/css"

gulp.task 'assets', ->
  gulp.src 'app/assets/**/*'
    .pipe gulp-filter -> it.path isnt /\.ls$/
    .pipe gulp.dest "#{build_path}"

gulp.task 'server', <[ build ]> ->
  app.use connect-livereload!
  app.use express.static path.resolve "#build_path"
  app.all '/**', (req, res, next) ->
    res.sendFile __dirname + "/#{build_path}/404.html"
  app.listen 3333
  gulp-util.log gulp-util.colors.bold.inverse 'Listening on port 3333'

gulp.task 'open' <[build server]> ->
  require! 'os'
  app = switch os.platform!
  | 'linux' => 'google-chrome'
  | 'win32' => 'Chrome'
  | 'darwin' => 'Google Chrome'
  | otherwise => 'Google Chrome' # TODO: findout other os

  gulp.src "#{build_path}/index.html"
    .pipe gulp-open '', do
      url: 'http://localhost:3333'
      app: app

gulp.task 'watch', <[ build server ]> ->
  gulp-livereload.listen silent: true
  gulp.watch [
    'app/**/*.jade',
    \app/assets/translations/*.json.ls,
    'md/**/*.md'
  ], <[ html ]> .on \change, gulp-livereload.changed
  gulp.watch 'app/**/*.less', <[ css ]> .on \change, gulp-livereload.changed
  gulp.watch 'app/**/*.ls', <[ js:app ]> .on \change, gulp-livereload.changed

gulp.task 'build', <[html js:vendor js:app assets css]>
gulp.task 'dev', <[ open watch ]>
gulp.task 'default', <[build]>
