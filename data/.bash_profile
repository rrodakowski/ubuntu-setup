# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

###########################
#### Set the prompt
###########################

#export PS1='$(whoami)@$(hostname):$(pwd)$ '
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[37m\]\n\$ \[\e[0m\]'

############################
### Terminal Coloring 
###########################

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
