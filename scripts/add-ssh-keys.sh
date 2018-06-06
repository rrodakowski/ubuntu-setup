#!/bin/bash

###############################
# Instructions to use this script
#
# 1) make sure the script is executable
# 2) enter your servers in the list below
# 3) script takes a username for which you want to pass public key
#    (the id_rsa.pub file) to the remote system where it renamed authorized_keys.
############################### 

servers="example1.com example2.com"
for server in $servers;
do 
    ssh-copy-id $1@$server;
done
