# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

#export PS1="\[\033[38;5;46m\]\u\[$(tput sgr0)\]\[\033[38;5;243m\]@\[$(tput sgr0)\]\[\033[38;5;226m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] [\[$(tput sgr0)\]\[\033[38;5;21m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\n\\$\[$(tput sgr0)\]"

# PS1='\e[33;1m\u@\h: \e[31m\W\e[0m\$ '

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

export PS1="[\[$UCCOLOR\]\u\[$bldwht\]@\[$bldylw\]\h\[$bldwht\] \[$bldblu\]\w\[$bldwht\]]\[$bldwht\]
\\$\[$bldwht\] "

export EDITOR=emacs

alias rsuball='find . -name . -o -type d -prune -o -exec rsub {} +'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_OPTS="--height 55% --reverse --border --inline-info"

fzfcmd(){
    file="$(fzf --preview 'bat --color=always {}')"
    if [[ "$file"  ]]; then
        rsub "$file"
    fi
}

alias rr='fzfcmd'

bind '"\C-F": "fzfcmd\C-m"'

commit(){

    comment="$1"
    if [[ $1 == "-m" ]]; then
        comment="$2"
    fi
    
    git add . && git commit -m "$comment" && git push
}

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"