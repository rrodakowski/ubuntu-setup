#!/bin/bash

#Instructions to use this script 
#
#chmod +x SCRIPTNAME.sh
#
#sudo ./SCRIPTNAME.sh

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

#other software I use
sudo apt-get -y install curl dropbox google-chrome-stable gimp pip  
# not necessary if using a droplet on digital ocean
#sudo apt-get -y install openssh-server openssh-client

#python installs using pip
sudo pip install oauth2


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

# folders
sudo mkdir /app-data
sudo mkdir /app-bin

sudo chgrp appadmin /app-data
sudo chgrp appadmin /app-bin

sudo chown appadmin /app-bin
sudo chown appadmin /app-data

# scripts
mkdir ~/scripts
cp -ar ./data/scripts/* ~/scripts/
chmod +x ~/scripts/*

# dotfiles
shopt -s dotglob
cp -a ./data/dotfiles/* ~

echo -e "\n"
