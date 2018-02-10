#!/bin/bash
# a bit hacky, but easiest way to force the script to run from the directory where it lives
cd "${0%/*}"
echo $(pwd)
# dependencies
sudo apt install zsh i3 rxvt-unicode
# x11
ln -sf $(pwd)/x11/xsessionrc ~/.xsessionrc
ln -sf $(pwd)/x11/xresources ~/.Xresources
# i3
ln -sf $(pwd)/i3 ~/.i3
# zsh
ln -sf $(pwd)/zsh/zshrc ~/.zshrc
# vim
ln -sf $(pwd)/vim ~/.vim
# Done
echo "Develra Dotfiles applied - logout and login to apply changes"
