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
  findutils \
  fish \
  fzf \
  gdbm \
  gettext \
  ghq \
  git \
  go \
  grpcurl \
  hadolint \
  icu4c \
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

if type fish 2>/dev/null; then
  readonly FISH_PATH=$(which fish)
  grep -x $FISH_PATH /etc/shells || sudo sh -c "echo $FISH_PATH >> /etc/shells"
  if [ $SHELL != $(which fish) ]; then
    chsh -s $FISH_PATH
  fi
fi

brew tap homebrew/cask
brew tap homebrew/cask-fonts

brew cask install \
  alacritty \
  authy \
  discord \
  docker \
  drawio \
  evernote \
  font-fira-mono-for-powerline \
  gimp \
  google-backup-and-sync \
  google-chrome \
  karabiner-elements \
  kindle \
  lens \
  synergy \
  visual-studio-code

# mas
#mas install 497799835 # Xcode

# python
type pip3.8 > /dev/null 2>&1 && pip3.8 install pip-review neovim pynvim powerline-status powerline-gitstatus Send2Trash

[ $OSTYPE != "msys" ] && source ./linktohome.sh
