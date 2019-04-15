#!/bin/bash
echo "Cloning homeshick"
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

echo "Adding homeshick to .bashrc"
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc

printf '\nsource "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"' >> $HOME/.bashrc

source ~/.bashrc

echo "Cloning homeshick"

homeshick clone r0zbot/dotfiles

exec bash