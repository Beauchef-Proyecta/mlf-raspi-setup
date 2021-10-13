#!/bin/bash
cd /home/pi/mlf
find . -mindepth 1 -maxdepth 1 -type d -print -exec sh /home/pi/mlf/setup/scripts/pull.sh {} \;