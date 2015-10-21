A repository for my ubuntu setup scripts. I included a VagrantFile, for reference. It calls a provisioning script to setup your VM.  

After provisioning a VM, there are generally several things to do, depending on app and your personal preference:

replace existing conf files / dotfiles with the ones inside data folder
append settings to existing conf files
add user to groups
copy scripts / program files into appropriate folders

Note: Pay attention to files that require root access to edit them. You won’t be able to do the following:

sudo echo "alpha" > /etc/some/important/file
sudo echo "bravo" >> /etc/some/other/important/file
The “sudo” applies only to “echo” in the examples above. Here’s how you replace and append contents of these files:

echo "alpha" | sudo tee /etc/some/important/file
echo "bravo" | sudo tee -a /etc/some/important/file
