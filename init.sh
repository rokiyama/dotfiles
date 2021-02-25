#!/bin/sh
set -uex

if !(type brew > /dev/null 2>&1); then
  curl -fsSLo- https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
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
  bluetoothconnector \
  coreutils \
  docker-completion \
  docker-compose-completion \
  findutils \
  fish \
  fzf \
  gdbm \
  gettext \
  ghq \
  git \
  gnu-sed \
  go \
  grpcurl \
  hadolint \
  htop \
  icu4c \
  jq \
  kind \
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
  svn \
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

brew install --cask \
  alacritty \
  alfred \
  authy \
  brave-browser \
  chrome-remote-desktop-host \
  deepl \
  discord \
  docker \
  drawio \
  evernote \
  gimp \
  google-backup-and-sync \
  google-chrome \
  karabiner-elements \
  kindle \
  lastpass \
  lens \
  mattermost \
  qlmarkdown \
  synergy \
  typora \
  visual-studio-code \
  zoom

# mas
#mas install 497799835 # Xcode

# python
type python3 > /dev/null 2>&1 && python3 -m pip install --user --upgrade pip-review pynvim powerline-status powerline-gitstatus Send2Trash

brew tap homebrew/cask-fonts
brew install --cask \
  font-fira-mono-for-powerline

[ $OSTYPE != "msys" ] && source ./linktohome.sh
