#!/bin/sh
set -uex

DOTFILES_DIR=~/.dotfiles

[[ -d $DOTFILES_DIR ]] || git clone https://github.com/rokiyama/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR

git pull
git submodule init
git submodule update

[ $OSTYPE != "msys" ] && source ./linktohome.sh

# xcode
xcode-select --install || echo 'xcode seems to be already installed'

# homebrew & brew-file
curl -sSL https://raw.github.com/rcmdnk/homebrew-file/install/install.sh | sh
export HOMEBREW_BREWFILE=$HOME/.dotfiles/Brewfile
export HOMEBREW_BREWFILE_ON_REQUEST=1
brew-file install

# python
type pip3 > /dev/null 2>&1 && pip3 install pip-review neovim pynvim powerline-status powerline-gitstatus Send2Trash
