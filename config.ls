exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  modules:
    definition: false
    wrapper: false
  paths:
    public: '_public'

  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^vendor/

    stylesheets:
      joinTo:
        'css/app.css': /^app\/styles\/\w+\.less/

  plugins:
    jaded:
      staticPatterns: /^app\/(.+)\.jade$/
  # Enable or disable minifying of result js / css files.
  # minify: true
