#!/usr/bin/env python

# start server with: python -m http.server --cgi

import cgi
import os

form = cgi.FieldStorage()
action = form['action'].value
direction = form['direction'].value

os.system('sudo python ../scripts/PiCarControl.py ' + action + ' ' + direction)
