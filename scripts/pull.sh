cd /home/pi/mlf
find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} reset --hard origin/main \;
find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} stash \;
find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;