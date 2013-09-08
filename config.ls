exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  modules:
    definition: false
    wrapper: (path, data) ->
      if [_, name]? = path.match /([^/\\]+)\.jsenv/
        """
(function() {
  var module = {};
  #{data};
  if (!window.global)
    window.global = {};
  window.global['#name'] = module.exports;
}).call(this);\n\n
        """
      else
        """
;\n
  #{data}
;\n\n
        """
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

  conventions:
    ignored: /^app\/styles\/_less/

  plugins:
    jaded:
      staticPatterns: /^app\/(.+)\.jade$/
  # Enable or disable minifying of result js / css files.
  # minify: true
