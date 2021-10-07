#!/bin/sh
if screen -ls | grep -q "stream" ;
then
  echo "stream is running!"
else
  echo "stream is NOT running!"
  screen -dmS stream
  sleep 0.5
  screen -S stream -X stuff  "workon mlf^M"
  sleep 0.5
  echo "starting stream..."
  screen -S stream -X stuff  "python /home/pi/stream_server/main.py^M"
  sleep 3
  echo "done"
fi