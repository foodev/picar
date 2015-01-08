#!/bin/bash
#
# compile all files
#
# author: Jonas Hantelmann <jonas@foodev.de>
# since: 2015-01-07
#

cd /home/pi/picar/src
ghc --make -o ../bin/picar Main.hs
cd - &> /dev/null
