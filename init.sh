#!/usr/bin/env bash
set -uex

[ $OSTYPE = "linux-gnu" ] && [ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
if !(type brew > /dev/null 2>&1); then
  curl -fsSLo- https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
fi

DOTFILES_DIR=~/.dotfiles

[[ -d $DOTFILES_DIR ]] || git clone https://github.com/rokiyama/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR

git pull

# brew
brew install \
  awscli \
  bat \
  docker-completion \
  docker-compose-completion \
  fish \
  fzf \
  gdbm \
  ghq \
  git \
  go \
  gotop \
  grpcurl \
  hadolint \
  hugo \
  jq \
  kind \
  luajit \
  neovim \
  oniguruma \
  openssl \
  pandoc \
  pcre2 \
  python \
  rbenv \
  ripgrep \
  ruby-build \
  sqlite \
  starship \
  svn \
  tmux \
  unibilium \
  xz

if [[ $OSTYPE =~ ^darwin ]]; then
  brew install \

  brew tap homebrew/cask
    bluetoothconnector \
    coreutils \
    findutils \
    gettext \
    gnu-sed \
    icu4c \
    libevent \
    libtermkey \
    libuv \
    libvterm \
    mas \
    msgpack \
    pkg-config \
    readline \
    reattach-to-user-namespace \
    switchaudio-osx \
    trash \
    unar \
    wakeonlan \
    watch

  brew install --cask \
    alacritty \
    alfred \
    chrome-remote-desktop-host \
    deepl \
    discord \
    docker \
    drawio \
    evernote \
    flutter \
    gimp \
    google-backup-and-sync \
    karabiner-elements \
    kindle \
    slack \
    typora \
    visual-studio-code \
    zoom

  # fonts
  brew tap homebrew/cask-fonts
  brew install --cask \
    font-fira-mono-nerd-font

  # mas
  mas install 497799835  # Xcode
  mas install 1352778147 # Bitwarden
fi

# fish
readonly FISH_PATH=$(brew --prefix)/bin/fish
if [ -f $FISH_PATH ]; then
  grep -x $FISH_PATH /etc/shells || sudo sh -c "echo $FISH_PATH >> /etc/shells"
  if [ $SHELL != $(which fish) ]; then
    chsh -s $FISH_PATH
  fi
fi

# python
type pip3 > /dev/null 2>&1 && pip3 install --user --upgrade pip-review pynvim powerline-status powerline-gitstatus Send2Trash

[ $OSTYPE != "msys" ] && source ./linktohome.sh
