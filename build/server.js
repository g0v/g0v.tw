var port = 8080;
var connect = require('connect');
connect.createServer(
    connect.static(__dirname)
).listen(port);
console.log('local server is running on port %d...',port);
