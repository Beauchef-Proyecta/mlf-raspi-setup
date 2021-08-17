# Set your Raspberry Pi 4 up

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

Perform the following changes:
- Update this tool
- Change `hostname` to `<your-favorite-mlp-character>`. 
**IMPORTANT**: In this example we will use `rainbowdash` as hostname
- Change `pass` to anything secure AND that you can remember
- Enable Camera
- Change TimeZone

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
sudo apt install git
sudp apt install python3-pip
sudo apt install cmake
````

