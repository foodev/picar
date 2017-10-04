#!/bin/bash
#
# compile all files
#
# author: Jonas Hantelmann <jonas@foodev.de>
# since: 2015-01-07
#

cd "$(dirname "${BASH_SOURCE[0]}")/src"
ghc -dynamic --make -o ../bin/picar Main.lhs
cd - &> /dev/null
