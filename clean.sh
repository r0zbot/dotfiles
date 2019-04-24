#!/bin/bash

cd $HOME

echo Cleaning homeshick files

rm -rf $HOME/.homesick/

echo Cleaning broken links
find -L $HOME -name . -o -type d -prune -o -type l -exec rm {} +
find -L $HOME/.ssh/ -name . -o -type d -prune -o -type l -exec rm {} +

echo Restoring first backup of .bashrc
mv $(ls .bashrc-*.bak | head -n 1) .bashrc

source .bashrc

bash


