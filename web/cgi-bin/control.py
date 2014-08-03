#!/usr/bin/env python

# start server with: python -m http.server --cgi

import cgi
import os

form = cgi.FieldStorage()
os.system('/home/pi/picar/bin/picar {0} {1}'.format(form['direction'].value, form['action'].value))

print 'Location: /index.html'
print
