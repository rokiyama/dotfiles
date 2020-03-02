#!/bin/sh
set -ux

# prerequisites: xcode cli tools and homebrew are installed
if !(type brew > /dev/null 2>&1); then
  echo 'brew does not exist' 1>&2
  exit 1
fi

DOTFILES_DIR=~/.dotfiles

[[ -d $DOTFILES_DIR ]] || git clone https://github.com/rokiyama/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR

git pull
git submodule init
git submodule update

[ $OSTYPE != "msys" ] && source ./linktohome.sh

# brew
brew install awscli
brew install bat
brew install coreutils
brew install fish
brew install fzf
brew install gdbm
brew install gettext
brew install ghq
brew install git
brew install go
brew install hadolint
brew install jq
brew install libevent
brew install libtermkey
brew install libuv
brew install libvterm
brew install luajit
brew install mas
brew install msgpack
brew install neovim
brew install nvm
brew install oniguruma
brew install openssl
brew install pcre2
brew install pkg-config
brew install python
brew install rbenv
brew install readline
brew install reattach-to-user-namespace
brew install ripgrep
brew install ruby-build
brew install sqlite
brew install tmux
brew install trash
brew install unar
brew install unibilium
brew install wakeonlan
brew install xz

brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew cask install alacritty
brew cask install chrome
brew cask install discord
brew cask install docker
brew cask install font-fira-mono-for-powerline
brew cask install google-backup-and-sync
brew cask install karabiner-elements
brew cask install mattermost
brew cask install visual-studio-code

# python
type pip3 > /dev/null 2>&1 && pip3 install pip-review neovim pynvim powerline-status powerline-gitstatus Send2Trash
