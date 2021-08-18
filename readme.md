# Set your Raspberry Pi 4 up for My Little Factory

This instructions will set your Raspberry Ready for My Little Factory, which uses popular resources, such as OpenCV and Flask.
## Flash an SD Card
We recommend you to use the Raspberry Pi Imager tool and flash the Raspbian OS Lite viersion (no desktop) to any SD Card with more than 16 Gb.

After flashing, mount the SD Card on your computer, open the `boot` volume and add an empty file named `ssh`. This will enable the SSH conections on the Raspberry Pi.

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

## Rename User

First, we need to enable root user, because no changes to the user name can be made while using the user. Enter the following command 
```sh
sudo passwd root
```
This will ask you to add a passwd to the root user. Please use something safe.

Enable root login through SSH by modifiyng the following line in the `/etc/ssh/sshd_config` file:

```sh
    PermitRootLogin Yes
```
The line is going to be commented when you first open it. You only need to uncomment the line and change `prohibitPassword`to `Yes`. To edit the file you can run:

```sh
sudo nano /etc/ssh/sshd_config
```
Reboot your raspi and log through SSH using the root user:
```sh
ssh root@rainbowdash.local
```

Rename `pi`user to `student` and create its new home folder:
```sh
usermod -l student pi
usermod -m -d /home/student student
```

Reboot and login to the new user through SSG:
```sh
ssh student@rainbowdash.local
```

Disable root user with the following command:
```sh
sudo passwd -l root
```

*Advice*: For now on, every time you need to use root user, we recommend to use
```sh
sudo -i
```

## Install some important software
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

## Install OpenCV depencencies
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

## Install Python3 virtual environments

We will stay with Python 3.7 (the default 3.x version that comes with the OS). We now need one of the most important tools to mantain everything stable: virtual environments. This is accomplished by installing `virtualenv` and `virtualenvwrapper`:

```sh
sudo pip3 install virtualenv virtualenvwrapper
```

Now we need to append some environment variables to our `.bashrc` file
```sh
echo "# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh  " >> ~/.bashrc
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
I everything is ok, our terminal shoul have `(mld)` at the beginning of each line, which meand that the environment has been created and activated.

## Install some Python packages in our environment

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
pip install "picamera[array]"
pip install flask
pip install numpy
pip install imutils
pip install opencv-contrib-python
```

To check that everything worked, open a python3 interpreter and import the packages:
```sh
python
>>> import cv2
>>> import flask
>>> import numpy
>>> import picamera
```

## Install remote.it daemon
```sh
curl -LkO https://raw.githubusercontent.com/remoteit/installer/master/scripts/auto-install.sh
chmod +x ./auto-install.sh
sudo ./auto-install.sh
````

