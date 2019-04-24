#!/bin/bash

cd $HOME

echo Cleaning homeshick files

rm -rf $HOME/.homesick/

echo Cleaning broken links
find -L $HOME -maxdepth 1 -type l -print -delete
find -L $HOME/.ssh -maxdepth 1 -type l -print -delete

echo Restoring first backup of .bashrc
mv $(ls .bashrc-*.bak | head -n 1) .bashrc

source .bashrc

bash


