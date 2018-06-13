###### ADD SERVICE to SYSTEMD ###########
# commands to add a service to startup 
#############################
SERVICE_FILE=$1
sudo cp SERVICE_FILE /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start $SERVICE_FILE
sudo systemctl enable $SERVICE_FILE

###### DEBUG help ###########
# you can check if it is running by typing
# sudo systemctl status miniircd
#
# you can see more information in log files: 
# sudo less /var/log/syslog
