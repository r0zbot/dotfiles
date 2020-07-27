# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PYTHONIOENCODING=utf-8

PATH=$PATH:~/bin
PATH=$PATH:~/.gem/ruby/2.6.0/bin

# If not running interactively, don't do anything below
case $- in
    *i*) ;; 
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

export EDITOR=nano

# Source other config files
[ -f ~/.ps1.bash ] && source ~/.ps1.bash
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /etc/profile.d/bash_completion.sh ] && source /etc/profile.d/bash_completion.sh

export FZF_DEFAULT_COMMAND="find . -type f ! -path '*.homesick/repos/homeshick*' ! -path '*.themes*' ! -path '*.cinnamon*' ! -path '*.cache*' ! -path '*.git/*' ! -path '*.cargo/*' ! -path '*.vscode-server/*' ! -path '*.emacs.d/*'"
export FZF_DEFAULT_OPTS="--height 55% --reverse --border --inline-info"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

homeshick refresh --quiet

# fuck thefuck
#if [[ $OS = "Windows_NT" ]]; then
#    eval "$(thefuck --alias | dos2unix)"
#    export CYGWIN=winsymlinks:nativestrict
#    export FZF_DEFAULT_OPTS="--reverse --border --inline-info"
#else
#    eval "$(thefuck --alias)"
#fi

shopt -s dotglob
