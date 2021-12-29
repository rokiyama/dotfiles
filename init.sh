#!/usr/bin/env bash
set -uex

[ $OSTYPE = "linux-gnu" ] && [ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
if !(type brew > /dev/null 2>&1); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

DOTFILES_DIR=$HOME/.dotfiles
[[ -d $DOTFILES_DIR ]] || git clone https://github.com/rokiyama/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR

git pull

# brew
brew install \
  awscli \
  bat \
  firebase-cli \
  fish \
  fzf \
  gdbm \
  gh \
  ghq \
  git \
  go \
  gotop \
  grpcurl \
  hadolint \
  hugo \
  jq \
  k3d \
  kubeseal \
  kustomize \
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
  rust \
  sqlite \
  starship \
  svn \
  tig \
  tmux \
  unibilium \
  xz \
  || echo 'brew install failed, continuing' >&2

[ $OSTYPE != "msys" ] && source ./linktohome.sh

# macos
if [[ $OSTYPE =~ ^darwin ]]; then
  brew install \
    bash \
    bluetoothconnector \
    coreutils \
    findutils \
    gettext \
    gnu-sed \
    icu4c \
    imagemagick \
    iperf3 \
    keycastr \
    libevent \
    libtermkey \
    libuv \
    libvterm \
    mas \
    msgpack \
    pkg-config \
    readline \
    reattach-to-user-namespace \
    shared-mime-info \
    switchaudio-osx \
    trash \
    unar \
    urlview \
    wakeonlan \
    watch \
    || echo 'brew install failed, continuing' >&2

  brew tap homebrew/cask

  brew install --cask \
    1password \
    alfred \
    android-studio \
    deepl \
    discord \
    docker \
    evernote \
    flutter \
    gimp \
    gitify \
    google-chrome \
    inkscape \
    karabiner-elements \
    kindle \
    numi \
    slack \
    visual-studio-code \
    || echo 'brew install failed, continuing' >&2

  brew tap earthly/earthly
  brew install earthly/earthly/earthly \
    || echo 'brew install failed, continuing' >&2

  # fonts
  brew tap homebrew/cask-fonts
  brew install --cask \
    font-fira-code-nerd-font \
    font-fira-mono-nerd-font \
    font-noto-sans-cjk-jp \
    || echo 'brew install failed, continuing' >&2

  # mas
  mas install 497799835  # Xcode
fi

# fish
readonly FISH_PATH=$(brew --prefix)/bin/fish
if [ -f $FISH_PATH ]; then
  grep -x $FISH_PATH /etc/shells || sudo sh -c "echo $FISH_PATH >> /etc/shells"
  if [ $SHELL != $(which fish) ]; then
    chsh -s $FISH_PATH
  fi
  fish -c "source $DOTFILES_DIR/fish_universal/abbr.fish"
  [ $OSTYPE = "linux-gnu" ] && fish -c "source $DOTFILES_DIR/fish_universal/linuxbrew.fish"
fi

# fzf
readonly FZF_INSTALL_PATH=$(brew --prefix)/opt/fzf/install
if [ -f $FZF_INSTALL_PATH ]; then
  $FZF_INSTALL_PATH --no-bash --no-zsh
fi

# bin directory
mkdir -p $HOME/bin
fish -c "fish_add_path $HOME/bin"

# python
type pip3 > /dev/null 2>&1 && pip3 install --user --upgrade pip-review pynvim Send2Trash

# tpm
TPM_DIR=$HOME/.cache/tmux/plugins/tpm
[[ -d $TPM_DIR ]] || git clone https://github.com/tmux-plugins/tpm.git $TPM_DIR
