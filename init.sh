#!/bin/sh
set -uex

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

# brew
brew install \
  awscli \
  bat \
  coreutils \
  fish \
  fzf \
  gdbm \
  gettext \
  ghq \
  git \
  grpcurl \
  go \
  hadolint \
  jq \
  libevent \
  libtermkey \
  libuv \
  libvterm \
  luajit \
  mas \
  msgpack \
  neovim \
  oniguruma \
  openssl \
  pcre2 \
  pkg-config \
  python \
  rbenv \
  readline \
  reattach-to-user-namespace \
  ripgrep \
  ruby-build \
  sqlite \
  tmux \
  trash \
  unar \
  unibilium \
  wakeonlan \
  watch \
  xz

brew install yarn --ignore-dependencies

brew tap homebrew/cask
brew tap homebrew/cask-fonts

brew cask install \
  alacritty \
  discord \
  docker \
  font-fira-mono-for-powerline \
  gimp \
  google-backup-and-sync \
  google-chrome \
  karabiner-elements \
  kindle \
  lens \
  synergy \
  visual-studio-code

# python
type pip3 > /dev/null 2>&1 && pip3 install pip-review neovim pynvim powerline-status powerline-gitstatus Send2Trash

[ $OSTYPE != "msys" ] && source ./linktohome.sh
