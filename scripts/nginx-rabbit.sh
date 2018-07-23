#!/bin/bash

#Instructions to use this script
#
# make sure the script is executable
# modify mysql passwords
# comment out packages that you may or may not need
# change install paths to directories that make sense

export INSTALL_HOME=/opt
export INSTALL_DATA=/vagrant/data

###############################
#####   Functions  ############
###############################

function add_user
{
    echo "adding user $1"
    sudo adduser $1 -ingroup appadmin
    sudo adduser $1 sudo
    sudo echo "$1:changeme" | sudo chpasswd
    # copy dot files
    shopt -s dotglob
    cp -a $INSTALL_DATA/dotfiles/* /home/$1
    chown $1 .*
    chgrp appadmin .*
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
##### Useful Software ###########
###############################

#nginx-light should be enough for our needs

sudo apt-get -y install nginx-light

# TODO: Automate the nginx configuration here
# based it on:
# https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-14-04-lts

# create www folders

sudo mkdir /var/www/randallrodakowski.com
sudo mkdir /var/www/randallrodakowski.com/html
sudo chgrp -R appadmin /var/www/randallrodakowski.com
sudo chown -R appadmin /var/www/randallrodakowski.com
echo "orangeshovel hello world" | sudo tee /var/www/randallrodakowski.com/html/index.html

sudo mkdir /var/www/orangeshovel.com
sudo mkdir /var/www/orangeshovel.com/html
sudo chgrp -R appadmin /var/www/orangeshovel.com
sudo chown -R appadmin /var/www/orangeshovel.com
echo "randallrodakowski hello world" | sudo tee /var/www/orangeshovel.com/html/index.html

# copy nginx config files to proper directory
sudo cp $INSTALL_DATA/www-config/orangeshovel.com /etc/nginx/sites-available/orangeshovel.com
sudo cp $INSTALL_DATA/www-config/randallrodakowski.com /etc/nginx/sites-available/randallrodakowski.com

# enable server blocks
sudo ln -s /etc/nginx/sites-available/orangeshovel.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/randallrodakowski.com /etc/nginx/sites-enabled/

# remove the default server block
sudo rm /etc/nginx/sites-enabled/default

# TODO: need to automate this configuration change using sed
# change /etc/nginx/nginx.conf
# We just need to uncomment one line. Find and remove the comment from this:
# server_names_hash_bucket_size 64;

#Restart all the installed services to verify that everything is installed properly

echo -e "\n"

sudo service nginx restart > /dev/null

echo -e "\n"

if [ $? -ne 0 ]; then
   echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi

###############################
##### RabbitMQ Install ########
###############################

sudo sh -c 'echo "deb http://www.rabbitmq.com/debian testing main" >> /etc/apt/sources.list'
wget https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
sudo apt-get update
sudo apt-get -y install rabbitmq-server
sudo rabbitmq-plugins enable rabbitmq_management

#The following commands set the rabbitMQ root password to MYPASSWORD123

sudo rabbitmqctl add_user appadmin MYPASSWORD123
sudo rabbitmqctl set_user_tags appadmin administrator
sudo rabbitmqctl set_permissions -p / appadmin ".*" ".*" ".*"

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
sudo pip install feedparser
sudo pip install pyyaml

# used for lxml, html cleaning, and other xml processing
sudo pip install lxml
sudo pip install SQLAlchemy

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

# create batch appliation folders

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
