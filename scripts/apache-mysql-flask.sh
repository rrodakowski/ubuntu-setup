#!/bin/bash

#Instructions to use this script 
#
# make sure the script is executable
# modify mysql passwords
# comment out packages that you may or may not need
#
#sudo ./ubuntu-setup.sh

###############################
##### Repo additions/updates ## 
###############################

#Update the repositories
sudo apt-get -y --force-yes update # Fetches the list of available updates 
sudo apt-get -y --force-yes upgrade # Strictly upgrades the current packages 
sudo apt-get dist-upgrade # Installs distribution updates (new ones), may install new pakcages or unintstall to satisfy dependecies i(careful)

###############################
##### LAMP Software ###########
###############################

#Apache, mod-wsgi, MySQL and required packages installation

sudo apt-get -y install apache2 mysql-client libapache2-mod-wsgi 

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

###############################
##### Desktop Software ########
###############################

#useful applications
sudo apt-get -y install curl vim

###############################
##### Server Software #########
###############################

# ssh not necessary if using a droplet on digital ocean
#sudo apt-get -y install openssh-server openssh-client

# install irssi
sudo apt-get -y install irssi irssi-scripts screen openssh-server

# security packages
sudo apt-get -y install fail2ban

# mail
sudo apt-get -y install postfix

# git used for private git repos
# git probably was installed to retrieve this setup script from github
sudo apt-get -y install git

# Installs for personal python applications
sudo apt-get -y install python-pip
sudo apt-get -y install imagemagick
# used for lxml, html cleaning, and other xml processing
sudo apt-get -y install python-lxml
# python installs using pip
sudo pip install oauth2
sudo pip install Pillow
sudo pip install MySQL-Python
sudo pip install feedparser
sudo pip install flask 

###############################
##### User & Folder Setup #####
###############################

# add users
sudo adduser appadmin
mkdir /home/appadmin/.ssh
chmod 700 /home/appadmin/.ssh
touch /home/appadmin/.ssh/authorized_keys
chmod 600 /home/appadmin/.ssh/authorized_keys
sudo adduser appadmin sudo

# copy dotfiles
shopt -s dotglob
cp -a ../data/* /home/appadmin

# app folders
sudo mkdir /app-data
sudo mkdir /app-bin

sudo chgrp appadmin /app-data
sudo chgrp appadmin /app-bin

sudo chown appadmin /app-bin
sudo chown appadmin /app-data

echo -e "\n"
