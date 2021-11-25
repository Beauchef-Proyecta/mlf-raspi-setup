# Set your Raspberry Pi 4 up for My Little Factory

This instructions will set your Raspberry Ready for My Little Factory, which uses popular resources, such as OpenCV and Flask.
## Flash an SD Card
We recommend you to use the Raspberry Pi Imager tool and flash the Raspbian OS Lite viersion (no desktop) to any SD Card with more than 16 Gb.

**IMPORTANT:** After flashing, mount the SD Card on your computer, open the `boot` volume and add an empty file named `ssh`. This will enable the SSH conections on the Raspberry Pi.

## Connect to your Pi via SSH
Load the card in the Raspberry Pi, connect it to a LAN (we recomend using an ethernet cable) and turn it on. Log into the Raspberry Pi through SSH:

In your own terminal type:
```sh
ssh pi@raspberrypi.local
```
Enter the default password: `raspberry`.

## System settings
Run the `raspi-config` tool as super user:
```sh
sudo raspi-config
```

Perform the following changes (you may want to check the boxes):
- [ ] Update this tool
- [ ] Expand the System
- [ ] Change `hostname` to `<your-favorite-mlp-character>`. 
**IMPORTANT**: In this example we will use `rainbowdash` as hostname
- [ ] Change `pass` to anything secure AND that you can remember
- [ ] Enable Camera
- [ ] Change TimeZone

Apply changes, reboot and log again through SSH.

## Install Libraries [*Fast*]

Clone this repo and execute `setup.sh`in the main folder

```sh
mkdir mlf
cd mlf
git clone https://github.com/Beauchef-Proyecta/mlf-raspi-setup.git setup

cd setup
chmod +x setup.sh
sudo sh setup.sh
```

Run the following lines
```
export WORKON_HOME=/home/pi/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
```

And then:
```sh
mkvirtualenv mlf
```
Make sure the virtual environment `mlf` is activated (`workon`). Then, upgrade pip and install the packages specified in `requirements.txt`
```sh
pip install --upgrade pip
pip install -r requirements.txt
```

## Enable remote access with ngrok & remot3.it

### Install ngrok agent

First get `<your-authtoken>` from [ngrok website](https://dashboard.ngrok.com/get-started/your-authtoken). Use this to authenticate the ngrok agent that you\'ll download.

In your raspi terminal, write this to create tunnels automatically every time the Raspberry Pi is restarted!:

```sh
curl -O https://raw.githubusercontent.com/Beauchef-Proyecta/mlf-raspi-setup/main/install.sh
chmod +x install.sh
sudo ./install.sh <your-authtoken>
```
Reboot to finish agent installation.
### Install remote.it daemon
```sh
curl -LkO https://raw.githubusercontent.com/remoteit/installer/master/scripts/auto-install.sh
chmod +x ./auto-install.sh
sudo ./auto-install.sh
```
Reboot the raspberry and log into the remot3.it wizard with the following command and follow the instructions to add services:
```sh
sudo connectd-installer
```
Remember that `ssh` service must use the default `22` port and the server must use the `5000` port.

## That's it!
Now yout raspberry should be ready to run the Little Factory software. Here can find the  [source code](https://github.com/Beauchef-Proyecta/mlf) :)
# Install libraries and envs [*Step-by-Step*]

> **IMPORTANT** 
This *step-by-step* instructions describe the exact same installation shown in previous sections.

First of all, update and upgrade `apt`, our package manager:
```sh
sudo apt update
sudo apt upgrade
```
The update part is fast; the upgrade part may take a while, so go grab some coffe if you want :)

Then, install these bad boys:
```sh
sudo apt install build-essential cmake pkg-config git python3-pip python3-dev screen
```

### Install OpenCV depencencies
Support for image formats
```sh
sudo apt install -y libjpeg-dev libtiff5-dev libjasper-dev libpng-dev
```
If it fails, add the `--fix-missing` flag:
```sh
sudo apt install -y --fix-missing libjpeg-dev libtiff5-dev libjasper-dev libpng-dev
```

Support for most common video codecs
```sh
sudo apt install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
```
Support for windows and graphical interfaces. This can take several mnitues.
```sh
sudo apt install -y libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev
```
Good ol' matrices optimization and Fortran <3
```sh
sudo apt install -y libatlas-base-dev gfortran
```
More support for graphical user interfaces (Qt and HDF5)
```sh
sudo apt install -y libhdf5-dev libhdf5-serial-dev libhdf5-103 libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5
```
More stuff that I don't know does it do:
```sh
sudo apt install -y libilmbase-dev libopenexr-dev libgstreamer1.0-dev
```

### Install Python3 virtual environments

We will stay with Python 3.7 (the default 3.x version that comes with the OS). We now need one of the most important tools to mantain everything stable: virtual environments. This is accomplished by installing `virtualenv` and `virtualenvwrapper`:

```sh
sudo pip3 install virtualenv virtualenvwrapper
```

Now we need to append some environment variables to our `.bashrc` file
```sh
echo "# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh " >> ~/.bashrc
```

now we source them!
```sh
source ~/.bashrc
```
On first run, `virtualenvwrapper` will create some folders
```sh
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/premkproject
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/postmkproject
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/initialize
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/premkvirtualenv
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/postmkvirtualenv
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/prermvirtualenv
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/postrmvirtualenv
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/predeactivate
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/postdeactivate
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/preactivate
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/postactivate
virtualenvwrapper.user_scripts creating /home/student/.virtualenvs/get_env_details
```
Now we are ready to create our virtualenvironment:
```sh
mkvirtualenv mlf -p python3
```
I everything is ok, our terminal shoul have `(mlf)` at the beginning of each line, which meand that the environment has been created and activated.

### Install some Python packages in our environment

Make sure the `mlf` environment is activated. If not, you can type:
```sh
workon mlf
```
`(mlf)` should append to the left of your terminal.

Upgrade pip with the folloing command:
```sh
pip install --upgrade pip
```
Now install some dependencies with pip
```sh
pip install -r requirements.txt
```

To check that everything worked, open a python3 interpreter and import the packages:
```sh
python
>>> import cv2
>>> import flask
>>> import numpy
>>> import picamera
```



