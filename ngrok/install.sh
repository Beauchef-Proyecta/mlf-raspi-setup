#!/usr/bin/env bash

if [ ! $(which wget) ]; then
    echo 'Please install wget package'
    exit 1
fi

if [ ! $(which git) ]; then
    echo 'Please install git package'
    exit 1
fi

if [ ! $(which unzip) ]; then
    echo 'Please install zip package'
    exit 1
fi

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

if [ -z "$1" ]; then
    echo "./install.sh <your_authtoken>"
    exit 1
fi

if [ ! -e ngrok.service ]; then
    git clone --depth=1 https://github.com/Beauchef-Proyecta/mlf-raspi-setup.git
    cd mlf-raspi-setup/ngrok
fi
cp ngrok.service /lib/systemd/system/
mkdir -p /opt/ngrok
cp ngrok.yml /opt/ngrok
sed -i "s/<your_authtoken>/$1/g" /opt/ngrok/ngrok.yml

cd /opt/ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip
unzip ngrok-stable-linux-arm.zip
rm ngrok-stable-linux-arm.zip
chmod +x ngrok

echo "Please run as root this command"

echo "systemctl enable ngrok.service"
echo "systemctl start ngrok.service"

systemctl enable ngrok.service
systemctl start ngrok.service