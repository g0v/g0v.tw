#!/usr/bin/env lsc -cj
name: 'g0v.tw'
version: '0.0.1'
description: 'g0v official website'
main: 'Gruntfile.js'
repository:
  type: 'git'
  url: 'https://github.com/g0v/g0v.tw'
keywords:
  * "g0v"
license: 'BSD'
scripts:
  prepublish: """
    node ./node_modules/LiveScript/bin/lsc -cj package.ls
    node ./node_modules/LiveScript/bin/lsc -cj bower.ls
    node ./node_modules/LiveScript/bin/lsc -c test/*.js.ls
  """
  build: 'gulp --require LiveScript'
  test: 'npm run build && bower i && ./node_modules/karma/bin/karma start --browsers PhantomJS --single-run true test/karma.conf.js'
  start: 'gulp --require LiveScript dev'
dependencies:
  marked: '~0.2.9'
  connect: '~2.8.4'
devDependencies:
  LiveScript: '1.1.x'
  'karma': '~0.12.0'
  'karma-live-preprocessor': '~0.2.0'
  'karma-phantomjs-launcher': "^0.1.2"
  'karma-mocha': '~0.1.0'
  'karma-chai': '~0.1.0'
  'karma-ng-scenario': '0.1.0'
  'bower': '~1.3.1'
  'mocha': '~1.18.2'
  'chai': '~1.9.1'
  'gulp-livereload': '~1.2.0'
  'connect-livereload': '~0.3.2'
  'gulp-livescript': '~0.2.1'
  'tiny-lr': '0.0.5'
  'gulp-less': '~1.2.3'
  'gulp-util': '~2.2.14'
  'gulp-jade': '~0.4.2'
  'gulp': '~3.6.0'
  'express': '~3.5.1'
  'gulp-insert': '~0.2.0'
  'gulp-concat': '~2.2.0'
  'gulp-commonjs': '~0.1.0'
  'gulp-json-editor': '~2.0.2'
  'streamqueue': '0.0.6'
  'gulp-uglify': '~0.2.1'
  'gulp-if': '~0.0.5'
  "gulp-bower": '~0.0.2'
  "gulp-bower-files": '>= 0.1.8'
  "gulp-filter": '~0.2.1'
