#!/bin/bash
echo "Cloning homeshick"
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

echo "Adding homeshick to .bashrc"
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc

printf '\nsource "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"' >> $HOME/.bashrc

source ~/.bashrc

echo "Cloning dotfiles"

homeshick clone r0zbot/dotfiles

echo -n "Install bat to ~/bin? [Y/n]"
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
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
if [ "$answer" == "${answer#[Yy]}" ] ;then
    git clone https://github.com/r0zbot/keys.git && rm -rf keys
    homeshick clone r0zbot/keys
    chmod 600 ~/.ssh/*
    chmod 700 ~/.ssh
    chmod -R u-w ~/.homesick
    chmod -R o-w ~/.homesick
fi

exec bash