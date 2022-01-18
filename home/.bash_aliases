#!/bin/bash

alias rr='fzfcmd'
#alias rsuball='find . -name . -o -type d -prune -o -exec rsub {} +'

# Color stuff
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cp='cp --reflink=auto'
alias please='sudo !!'

alias ll='ls -lah'
alias cls='clear'
alias catp='/bin/cat'
alias caf='bat $(fzf)'
alias cat='bat'

if [ -n "$WSL_DISTRO_NAME" ]; then
    alias mount-media='sudo mount -t drvfs Z: /mnt/media'
fi


function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.xz)    tar xf $1       ;;
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function cd(){
    if [[ $1 =~ ^[a-zA-Z]:.* ]]; then
        builtin cd "$(winpath "$1")"
    else
        builtin cd "$@"
    fi
}

function pullrequest(){
    was_on_master="false"
    if [[ "$(git branch | grep '*')" == "* master" ]]; then
        read -p "You are on master. Enter name for a new branch: " newbranch
        git checkout -b "$newbranch"  || return
        was_on_master="true"
    fi

    comment="$1"
    if [[ $1 == "-m" ]]; then
        comment="$2"
    fi

    git add -A && git commit -m "$comment" && gh pr create --fill || return

    if [[ "$was_on_master" == "true" ]]; then
        git checkout master || return
        git pull || return
        
    fi
}

function seecert () {   nslookup $1
  (openssl s_client -showcerts -servername $1 -connect $1:443 <<< "Q" | openssl x509 -text | grep -iA2 "Validity");
}



transfer() { 
    curl --version 2>&1 > /dev/null
    if [ $? -ne 0 ]; then
        echo "Could not find curl."
        return 1
    fi
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

commit(){

    comment="$1"
    if [[ $1 == "-m" ]]; then
        comment="$2"
    fi
    
    git add -A && git commit -m "$comment" && git push
}

fzfcmd(){
    file="$(fzf -m --preview 'bat --color=always {}')"
    if [[ "$file"  ]]; then
        rsub "$file"
    fi
}

kzf(){
    file="$(fzf -m --preview 'bat --color=always {}')"
    if [[ "$file"  ]]; then
        kate "$file" &
    fi
}


bind '"\C-P": "fzfcmd\C-m"'
bind '"\C-K": "kzf\C-m"'

alias k=kubectl
complete -F __start_kubectl k

source <(kubectl completion bash)
