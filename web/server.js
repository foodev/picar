var WebSocketServer = require('websocket').server;
var exec = require('child_process').exec;

var config = {
    htmlTemplate: '/home/pi/picar/web/index.html'
};

var http = require('http').createServer(function(request, response) {
    require('fs').readFile(config.htmlTemplate, function(error, html) {
        response.writeHead(200, {'content-type': 'text/html'});
        response.write(html);
        response.end();
    });
});
http.listen(8080);

websocket = new WebSocketServer({
    httpServer: http,
    autoAcceptConnections: false
});

var clients = [];

websocket.on('request', function(request) {
    var client = request.accept('picar', request.origin);

    clients.push(client);

    // process commands
    client.on('message', function(message) {
        data = JSON.parse(message.utf8Data);

        exec(require('util').format('/home/pi/picar/bin/picar %s %s', data.direction, data.action));
    });
});
