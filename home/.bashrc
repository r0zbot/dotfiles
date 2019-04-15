# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

PATH=$PATH:~/bin

export EDITOR=emacs

# Source other config files
[ -f ~/.ps1.bash ] && source ~/.ps1.bash
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND="find . -type f ! -path '*.homesick/repos/homeshick*' ! -path '*.themes*' ! -path '*.cinnamon*' ! -path '*.cache*' ! -path '*.git/*'"
export FZF_DEFAULT_OPTS="--height 55% --reverse --border --inline-info"

fzfcmd(){
    file="$(fzf -m --preview 'bat --color=always {}')"
    if [[ "$file"  ]]; then
        rsub "$file"
    fi
}

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

homeshick refresh --quiet

