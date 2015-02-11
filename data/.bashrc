# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

##################################################
### User specific environment and startup programs
##################################################

export INSTALL_HOME=/opt

export JAVA_HOME=/Library/Java/Home
export CATALINA_HOME=$INSTALL_HOME/apache-tomcat-7.0.30
export TNS_ADMIN=$INSTALL_HOME/instaclient
export ORACLE_HOME=$INSTALL_HOME/instaclient
export LD_LIBRARY_PATH=$INSTALL_HOME/instaclient
export MAGICK_HOME=$INSTALL_HOME/ImageMagick-6.8.9

DYLD_LIBRARY_PATH=$INSTALL_HOME/instaclient
DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$MAGICK_HOME/lib
export DYLD_LIBRARY_PATH

PATH=$PATH:$JAVA_HOME/bin
PATH=$PATH:$CATALINA_HOME/bin
PATH=$PATH:$TNS_ADMIN
PATH=$PATH:$MAGICK_HOME/bin
#/usr/local/bin is usually already on the path by default
#PATH=$PATH:/usr/local/bin 

export PATH

#############################
### Aliases 
############################
# ci box
alias connect_ci='ssh prodop@cps-dw-ci.amers1b.ciscloud'

# dev db server c358skncpdvpb.int.westgroup.com 
alias connect_agg_dev='ssh rrodako@c223pgjcpdvpb.int.westgroup.com'
alias connect_ue_dev='ssh rrodako@c571keqcpdvpb.int.westgroup.com'
alias connect_bdb1_dev='ssh rrodako@C837wqhcpdvpb.int.westgroup.com' #webstat
alias connect_bdb2_dev='ssh rrodako@C819vqhcpdvpb.int.westgroup.com' #datavision

# test db server c620rjccptepb.int.westgroup.com
alias connect_agg_test='ssh rrodako@c269gaucptepb.int.westgroup.com'
alias connect_ue_test='ssh rrodako@c006zuncptepb.int.westgroup.com'
alias connect_bdb1_test='ssh rrodako@C172DYSCPTEPB.int.westgroup.com'
alias connect_bdb2_test='ssh rrodako@c641mtycptepb.int.westgroup.com'

# qed db server c218arvcpprpb.int.westgroup.com
alias connect_agg_qed='ssh rrodako@c890jsncpprpb.int.westgroup.com'
alias connect_ue_qed='ssh rrodako@c803gqkcpprpb.int.thomsonreuters.com'
alias connect_bdb1_qed='ssh rrodako@c198wxgcpprpb.int.westgroup.com'
alias connect_bdb2_qed='ssh rrodako@c069dkrcpprpb.int.westgroup.com'

# prod db server c914xzscpprpb.int.westgroup.com
alias connect_agg_prod='ssh rrodako@c648wtgcpprpb.int.westgroup.com'
alias connect_ue_prod='ssh rrodako@c883wyscpprpb.int.westgroup.com'
alias connect_bdb1_prod='ssh rrodako@c667vjrcpprpb.int.westgroup.com'
alias connect_bdb2_prod='ssh rrodako@c903thncpprpb.int.westgroup.com'

#CPS boxes
alias connect_cps_prod='ssh rrodako@cps-prod-app.int.thomsonreuters.com'
alias connect_cps_preprod='ssh rrodako@cps-preprod-app.int.thomsonreuters.com'
alias connect_cps_qa='ssh rrodako@cps-qa-app.int.thomsonreuters.com'
alias connect_cps_int='ssh rrodako@cps-int-app.int.thomsonreuters.com'

alias connect_ctest1='ssh rrodako@cps-ol6-ctest1-app.int.riag.com'
alias connect_ctest2='ssh rrodako@cps-ol6-ctest2-app.int.riag.com'
alias connect_ctest3='ssh rrodako@cps-ol6-ctest3-app.int.riag.com'
alias connect_ctest4='ssh rrodako@cps-ol6-ctest4-app.int.riag.com' # don't know my signon to this box

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


