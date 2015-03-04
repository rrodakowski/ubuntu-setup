#!/bin/bash

#Instructions to use this script 
#
# make sure the script is executable
# modify mysql passwords
# comment out packages that you may or may not need
#
#sudo ./ubuntu-setup.sh

echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "###################################################################################"

#Add Repositories
sudo add-apt-repository -y "deb http://dl.google.com/linux/chrome/deb/ stable main"
sudo add-apt-repository -y "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main"

#Update the repositories
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

#Apache, Php, MySQL and required packages installation

sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client
php5enmod mcrypt

#other software I use for a desktop installation
sudo apt-get -y install curl dropbox google-chrome-stable gimp geany terminator vim
#allow me to read exfat file system (external usb harddrive)
sudo apt-get -y install fuse exfat-fuse

# ssh not necessary if using a droplet on digital ocean
#sudo apt-get -y install openssh-server openssh-client

#install irssi
sudo apt-get -y install irssi irssi-scripts screen openssh-server

#security packages
sudo apt-get -y install fail2ban

#mail
sudo apt-get -y install postfix

#TODO: work on python installation
#python installs using pip
#sudo apt-get install pip
#sudo pip install oauth2


#The following commands set the MySQL root password to MYPASSWORD123 when you install the mysql-server package.

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD123'

sudo apt-get -y install mysql-server

#Restart all the installed services to verify that everything is installed properly

echo -e "\n"

service apache2 restart && service mysql restart > /dev/null

echo -e "\n"

if [ $? -ne 0 ]; then
   echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi

#add users
sudo adduser appadmin
mkdir /home/appadmin/.ssh
chmod 700 /home/deploy/.ssh

# app folders
sudo mkdir /app-data
sudo mkdir /app-bin

sudo chgrp appadmin /app-data
sudo chgrp appadmin /app-bin

sudo chown appadmin /app-bin
sudo chown appadmin /app-data

# dotfiles
shopt -s dotglob
cp -a ../data/* ~

echo -e "\n"
