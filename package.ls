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
  build: 'gulp'
  test: 'npm run build && bower i && ./node_modules/karma/bin/karma start --browsers PhantomJS --single-run true test/karma.conf.js'
  start: 'gulp dev'
dependencies:
  marked: '^0.2.10'
  connect: '^2.8.8'
devDependencies:
  'LiveScript': '^1.3.0'
  'bower': '^1.3.4'
  'chai': '~1.9.1'
  'connect': '^2.19.1'
  'connect-livereload': '^0.4.0'
  'express': '^4.3.1'
  'gulp': '^3.7.0'
  'gulp-bower': '~0.0.2'
  'gulp-commonjs': '~0.1.0'
  'gulp-concat': '~2.2.0'
  'gulp-filter': '^0.4.1'
  'gulp-if': '^1.2.1'
  'gulp-insert': '^0.3.0'
  'gulp-jade': '^0.5.0'
  'gulp-json-editor': '~2.0.2'
  'gulp-less': '~1.2.3'
  'gulp-livereload': '^2.0.0'
  'gulp-livescript': \>=1.1.0
  'gulp-open': '^0.2.8'
  'gulp-plumber': '^0.6.2'
  'gulp-rename': \>=1.2.0
  'gulp-uglify': '^0.3.0'
  'gulp-util': '~2.2.14'
  'karma': '^0.12.16'
  'karma-live-preprocessor': '~0.2.0'
  'karma-phantomjs-launcher': "^0.1.4"
  'karma-mocha': '~0.1.0'
  'karma-chai': '~0.1.0'
  'karma-ng-scenario': '0.1.0'
  'main-bower-files': '^1.0.1'
  'marked': '^0.3.2'
  'mocha': '^1.19.0'
  'streamqueue': '^0.1.0'
  'tiny-lr': '^0.0.7'
