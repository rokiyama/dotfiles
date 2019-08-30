#!/bin/sh

DOTFILES_DIR=~/.dotfiles

[[ -d $DOTFILES_DIR ]] || git clone https://github.com/rokiyama/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR

git pull
git submodule init
git submodule update

[ $OSTYPE != "msys" ] && source ./linktohome.sh

type pip3 > /dev/null 2>&1 && pip3 install pip-review neovim pynvim powerline-status powerline-gitstatus Send2Trash
