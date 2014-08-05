#!/usr/bin/env python

import os
from BaseHTTPServer import HTTPServer
from CGIHTTPServer import CGIHTTPRequestHandler

os.chdir('/home/pi/picar/web');

server = HTTPServer(('', 8080),CGIHTTPRequestHandler)

try:
    print 'Server listening on localhost:8080'
    server.serve_forever()
except KeyboardInterrupt:
    # gracefully shut down the server on `Ctrl + C`
    server.shutdown()
