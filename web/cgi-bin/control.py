#!/usr/bin/env python

# start server with: python -m http.server --cgi

import cgi
import os

form = cgi.FieldStorage()
os.system('sudo python ../scripts/PiCarControl.py {0} {1}'.format(form['action'].value, form['direction'].value))
