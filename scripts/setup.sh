#!/bin/sh

DOTFILES_DIR=$HOME/.dotfiles
[ -d $DOTFILES_DIR ] || git clone https://github.com/rokiyama/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR

apt update
apt install -y fish less
fish -c "source $DOTFILES_DIR/dotconfig/fish/abbr.fish"
