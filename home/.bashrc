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

PATH=$PATH:~/bin
alias rsuball='find . -name . -o -type d -prune -o -exec rsub {} +'

export EDITOR=emacs

# Source ps1 and fzf config
[ -f ~/.ps1.bash ] && source ~/.ps1.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND="find . -type f ! -path '*.homesick/repos/homeshick*' ! -path '*.themes*' ! -path '*.cinnamon*' ! -path '*.cache*' ! -path '*.git/*'"
export FZF_DEFAULT_OPTS="--height 55% --reverse --border --inline-info"

fzfcmd(){
    file="$(fzf -m --preview 'bat --color=always {}')"
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