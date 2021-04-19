#!/usr/bin/env bash
set -uex

if !(type brew > /dev/null 2>&1); then
  curl -fsSLo- https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
fi
[ $OSTYPE = "linux-gnu" ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

DOTFILES_DIR=~/.dotfiles

[[ -d $DOTFILES_DIR ]] || git clone https://github.com/rokiyama/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR

git pull

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
  unar \
  unibilium \
  xz

# brew
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
    trash \
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
    typora \
    visual-studio-code \
    zoom

  # mas
  mas install 497799835  # Xcode
  mas install 1352778147 # Bitwarden
fi

# fish
if type fish 2>/dev/null; then
  readonly FISH_PATH=$(which fish)
  grep -x $FISH_PATH /etc/shells || sudo sh -c "echo $FISH_PATH >> /etc/shells"
  if [ $SHELL != $(which fish) ]; then
    chsh -s $FISH_PATH
  fi
fi

# python
type pip3 > /dev/null 2>&1 && pip3 install --user --upgrade pip-review pynvim powerline-status powerline-gitstatus Send2Trash

# fonts
brew tap homebrew/cask-fonts
brew install --cask \
  font-fira-mono-nerd-font

[ $OSTYPE != "msys" ] && source ./linktohome.sh
