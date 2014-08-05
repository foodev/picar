#!/usr/bin/env python

import os, sys
from BaseHTTPServer import HTTPServer
from CGIHTTPServer import CGIHTTPRequestHandler

# abort if not at least one command line argument was set (the port)
if len(sys.argv) < 2:
    print 'Usage: %s [port]' % sys.argv[0]
    sys.exit(1)

port = int(sys.argv[1])

os.chdir('/home/pi/picar/web')
server = HTTPServer(('', port), CGIHTTPRequestHandler)

try:
    print 'Server listening on localhost:%i' % port
    server.serve_forever()
except KeyboardInterrupt:
    # gracefully shut down the server on `Ctrl + C`
    print 'Server stopped. Bye!'
    server.shutdown()

sys.exit(0)
