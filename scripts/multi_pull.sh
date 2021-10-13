#!/bin/bash
cd /home/pi/mlf

find . -mindepth 1 -maxdepth 1 -type d -print -exec setup/scripts/pull.sh {} \;

chmod +x setup/scripts/pull.sh