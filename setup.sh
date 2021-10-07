#!/bin/bash

echo "Updating and Upgrading apt" | tee install_logs
apt update && sudo apt upgrade | tee -a install_logs

echo "Installing dev essentials" | tee -a install_logs
apt install -y build-essential cmake pkg-config git python3-pip python3-dev screen | tee -a install_logs

echo "Installing libraries" | tee -a install_logs
apt install -y --fix-missing libjpeg-dev libtiff5-dev libjasper-dev libpng-dev | tee -a install_logs
apt install -y --fix-missing libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev | tee -a install_logs
apt install -y --fix-missing libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev | tee -a install_logs
apt install -y --fix-missing libatlas-base-dev gfortran | tee -a install_logs
apt install -y --fix-missing libhdf5-dev libhdf5-serial-dev libhdf5-103 libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5 | tee -a install_logs
apt install -y --fix-missing libilmbase-dev libopenexr-dev libgstreamer1.0-dev | tee -a install_logs

echo "Installing virtualenv and virtualenvwrapper for Python3" | tee -a install_logs
pip3 install --upgrade pip
pip3 install virtualenv virtualenvwrapper | tee -a install_logs


sudo -u pi cat >> /home/pi/.bashrc << EOL
# virtualenv and virtualenvwrapper
export WORKON_HOME=/home/pi/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
EOL
