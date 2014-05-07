name: "g0v.tw"
repo: "g0v/g0v.tw"
version: "0.0.1"
main: "_public/js/app.js"
ignore: ["**/.*", "node_modules", "components"]
dependencies:
  jquery: "=1.8.2"
  angular: "1.2.14"
  "angular-mocks": "1.2.3"
  "angular-scenario": "1.2.3"
  "angular-markdown-directive": "0.1.0"
  "angular-translate": "2.1.0"
  "angular-translate-loader-static-files": "2.1.0"

overrides:
  "angular-mocks":
    main: "README.md"
  "angular-scenario":
    main: "README.md"

resolutions:
  angular: "1.2.3"

