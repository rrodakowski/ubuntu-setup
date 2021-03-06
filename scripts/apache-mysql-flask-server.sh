#!/bin/bash

#Instructions to use this script 
#
# make sure the script is executable
# modify mysql passwords
# comment out packages that you may or may not need
#

export INSTALL_HOME=/opt
export INSTALL_DATA=/vagrant/data

###############################
#####   Functions  ############
###############################

function add_user
{
    echo "adding user $1"
    sudo adduser $1 -g appadmin 
    mkdir /home/$1/.ssh
    chmod 700 /home/$1/.ssh
    touch /home/$1/.ssh/authorized_keys
    chmod 600 /home/$1/.ssh/authorized_keys
    sudo adduser $1 sudo
    sudo echo "$1:changeme" | sudo chpasswd
    # copy dot files
    shopt -s dotglob
    cp -a $INSTALL_DATA/dotfiles/* /home/$1
}

###############################
###############################
#####   START OF SCRIPT  ######
###############################
###############################

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

# Software for image processing
sudo apt-get -y install imagemagick

# Python Package manager
sudo apt-get -y install python-pip

# python installs using pip
sudo pip install oauth2
sudo pip install MySQL-Python
sudo pip install feedparser
sudo pip install flask 
sudo pip install SQLAlchemy
sudo pip install flask-sqlalchemy

# used for lxml, html cleaning, and other xml processing
sudo pip install lxml
# aws packages
sudo pip install awscli
sudo pip install boto3

###############################
##### User & Folder Setup #####
###############################

sudo groupadd appadmin 
# add users
add_user appadmin 
add_user randall 

# copy dotfiles
shopt -s dotglob
cp -a $INSTALL_DATA/dotfiles/* /home/vagrant

# app folders

sudo mkdir /var/www/randallrodakowski.com
sudo mkdir /var/www/randallrodakowski.com/public_html
sudo chgrp -R appadmin /var/www/randallrodakowski.com 
sudo chown -R appadmin /var/www/randallrodakowski.com 

sudo mkdir /app-data
sudo mkdir /app-data/logs
sudo mkdir /app-data/logs/cap-log
sudo mkdir /app-data/logs/irc-log
sudo mkdir /app-bin

sudo chgrp -R appadmin /app-data
sudo chgrp -R appadmin /app-bin

sudo chown -R appadmin /app-bin
sudo chown -R appadmin /app-data

echo -e "\n"
