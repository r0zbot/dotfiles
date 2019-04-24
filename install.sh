#!/bin/bash

if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
    echo "Cloning homeshick"
    git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

echo "Adding homeshick to .bashrc"

mv .bashrc .bashrc-$(date +%Y-%m-%d_%s).bak

touch .bashrc

printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc

printf '\nsource "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"' >> $HOME/.bashrc

source $HOME/.bashrc

source $HOME/.homesick/repos/homeshick/homeshick.sh

echo "Cloning dotfiles"

homeshick clone r0zbot/dotfiles

echo -n "Install bat to ~/bin? [Y/n]"
read answer
if [[ "$answer" != "${answer#[Yy]}" ]] || [[ -z $answer ]] ;then
    mkdir tmpbat
    mkdir -p ~/bin
    cd tmpbat
    wget https://github.com/sharkdp/bat/releases/download/v0.10.0/bat-v0.10.0-x86_64-unknown-linux-gnu.tar.gz
    tar xzf bat-v0.10.0-x86_64-unknown-linux-gnu.tar.gz
    mv bat-v0.10.0-x86_64-unknown-linux-gnu/bat ~/bin
    cd ..
    rm -rf tmpbat

fi

echo -n "Clone ssh keys? [Y/n]"
read answer
if [[ "$answer" != "${answer#[Yy]}" ]] || [[ -z $answer ]] ;then
    olddir="$(pwd)"
    git clone https://github.com/r0zbot/keys.git && rm -rf keys
    homeshick clone r0zbot/keys
    chmod 600 ~/.ssh/*
    chmod 700 ~/.ssh
    chmod -R u-w ~/.homesick
    chmod -R o-w ~/.homesick
    homeshick cd keys
    git remote set-url origin git@github.com:r0zbot/keys.git
    homeshick cd dotfiles
    git remote set-url origin git@github.com:r0zbot/dotfiles.git
    cd "$olddir"
fi

exec bash
