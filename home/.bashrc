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
PATH=$PATH:~/.gem/ruby/2.6.0/bin

export EDITOR=emacs

# Source other config files
[ -f ~/.ps1.bash ] && source ~/.ps1.bash
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /etc/profile.d/bash_completion.sh ] && source /etc/profile.d/bash_completion.sh

export FZF_DEFAULT_COMMAND="find . -type f ! -path '*.homesick/repos/homeshick*' ! -path '*.themes*' ! -path '*.cinnamon*' ! -path '*.cache*' ! -path '*.git/*'"
export FZF_DEFAULT_OPTS="--height 55% --reverse --border --inline-info"

fzfcmd(){
    file="$(fzf -m --preview 'bat --color=always {}')"
    if [[ "$file"  ]]; then
        rsub "$file"
    fi
}

#
# Defines transfer alias and provides easy command line file and folder sharing.
#
# Authors:
#   Remco Verhoef <remco@dutchcoders.io>
#

curl --version 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "Could not find curl."
  return 1
fi

transfer() { 
    if [ $# -eq 0 ]; 
    then 
        echo "No arguments specified. Usage:echo transfer /tmp/test.md  or cat /tmp/test.md | transfer test.md"
        return 1
    fi

    tmpfile=$( mktemp -t transferXXX )
    file=$1

    if tty -s; 
    then 
        basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 

        if [ ! -e $file ];
        then
            echo "File $file doesn't exists."
            return 1
        fi
        
        if [ -d $file ];
        then
            zipfile=$( mktemp -t transferXXX.zip )
            cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
            curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
            rm -f $zipfile
        else
            curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
        fi
    else 
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
    fi
   
    cat $tmpfile
    rm -f $tmpfile
}


kzf(){
    file="$(fzf -m --preview 'bat --color=always {}')"
    if [[ "$file"  ]]; then
        kate "$file" &
    fi
}

bind '"\C-F": "fzfcmd\C-m"'

bind '"\C-K": "kzf\C-m"'

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
