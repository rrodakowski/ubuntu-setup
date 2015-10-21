A repository to help me setup Virtual Machines for development. 

### Necessary Dependencies

- Install Virtual Box (or VM provider of choice)
- Install Vagrant

### Steps to run

Copy the contents of this repsository to a folder on your machine in which you would like spin up your vagrant instance. There is a sample vagrant file. It calls a provisioning script to setup your VM.  

After Vm is running and provisioned:

- vagrant ssh -- to connect
- vagrant halt to shut down the VM(s)
- vagrant suspend to suspend the VM(s), use vagrant resume to resume
- vagrant status to display the status of the VM(s)
- vagrant destroy to destroy (delete) the VM(s)

After provisioning a VM, there are generally several things to do, depending on app and your personal preference:

replace existing conf files / dotfiles with the ones inside data folder
append settings to existing conf files
add user to groups
copy scripts / program files into appropriate folders

#### Note: Pay attention to files that require root access to edit them. You won’t be able to do the following:

sudo echo "alpha" > /etc/some/important/file
sudo echo "bravo" >> /etc/some/other/important/file
The “sudo” applies only to “echo” in the examples above. Here’s how you replace and append contents of these files:

echo "alpha" | sudo tee /etc/some/important/file
echo "bravo" | sudo tee -a /etc/some/important/file
