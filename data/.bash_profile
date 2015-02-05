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

############################
### Terminal Coloring 
###########################

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

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
