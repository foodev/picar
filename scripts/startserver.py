#!/usr/bin/env python

import os
from BaseHTTPServer import HTTPServer
from CGIHTTPServer import CGIHTTPRequestHandler

os.chdir('../web');

serv = HTTPServer(('', 8080),CGIHTTPRequestHandler)
serv.serve_forever()
