#!/bin/bash

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

UCCOLOR=$bldgrn               # user's color
[ $UID -eq "0" ] && UCCOLOR=$bldred 

if [[ $(hostname) == "r0zmain" ]]; then
    hostcolor=$txtcyn
elif [[ $(hostname) == "imesec.ime.usp.br" ]]; then
    hostcolor=$bldylw
elif [[ $(hostname) == "osmc" ]]; then
    hostcolor=$bldpur
elif [[ $(hostname) == "BusterJr" ]]; then
    hostcolor=$txtred
elif [[ $(hostname) == "r0znot" ]]; then
    hostcolor=$txtylw
else
    hostcolor=$txtwht
fi

[ -x "$(command -v kubectx)" ] && export ctx_ps1=" |\[$bldylw\]\$(kubens -c)\[$bldwht\]@\[$bldylw\]\$(kubectx -c)\[$bldwht\]|"

#if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    # export GIT_PS1_SHOWUPSTREAM="true"
    export GIT_PS1_SHOWCOLORHINTS=true
    #source /usr/lib/git-core/git-sh-prompt
    source ~/.bash_git
    PROMPT_COMMAND="history -a && __git_ps1 '[\[$UCCOLOR\]\u\[$bldwht\]@\[$hostcolor\]\h\[$bldwht\] \[$bldblu\]\w\[$bldwht\]]$ctx_ps1\[$bldwht\]' '
\\$\[$txtwht\] '  ' (%s)'"
#else
#    export PS1="[\[$UCCOLOR\]\u\[$bldwht\]@\[$hostcolor\]\h\[$bldwht\] \[$bldblu\]\w\[$bldwht\]]\[$bldwht\]
#\\$\[$txtwht\] "
#fi



# set ps1 indirectly, using __git_ps1

