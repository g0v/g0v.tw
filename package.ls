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
  build: 'brunch b'
  test: 'npm run build && bower i && ./node_modules/karma/bin/karma start --browsers PhantomJS --single-run true test/karma.conf.js'
  start: './node_modules/.bin/brunch watch --server'
dependencies:
  marked: '~0.2.9'
  connect: '~2.8.4'
devDependencies:
  LiveScript: '1.1.x'
  brunch: '1.6.x'
  'javascript-brunch': '1.6.x'
  'LiveScript-brunch': '1.6.x'
  'css-brunch': '1.6.x'
  'less-brunch': '1.5.x'
  'markdown-brunch': '1.6.x'
  'jaded-brunch': '1.7.x'
  'auto-reload-brunch': '1.6.x'
  'uglify-js-brunch': '1.5.x'
  'clean-css-brunch': '1.6.x'
  'jsenv-brunch': '1.4.2'
  'karma': '~0.12.0'
  'karma-live-preprocessor': '~0.2.0'
  'karma-phantomjs-launcher': "^0.1.2"
  'karma-mocha': '~0.1.0'
  'karma-chai': '~0.0.2'
  'karma-ng-scenario': '0.1.0'
  'bower': '1.2.x'
  'mocha': '~1.14.0'
  'chai': '~1.8.0'
