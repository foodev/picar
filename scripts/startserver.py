#!/usr/bin/env python

import os
from BaseHTTPServer import HTTPServer
from CGIHTTPServer import CGIHTTPRequestHandler

os.chdir('/home/pi/picar/web');

serv = HTTPServer(('', 8080),CGIHTTPRequestHandler)
serv.serve_forever()

print 'Server listening on localhost:8080'
