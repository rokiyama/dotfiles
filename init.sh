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
  asciidoctor \
  awscli \
  bat \
  deno \
  fd \
  fish \
  fzf \
  gh \
  ghq \
  git \
  go \
  hadolint \
  hugo \
  jq \
  k3d \
  luajit \
  neovim \
  oniguruma \
  openssl \
  pandoc \
  pcre2 \
  pipx \
  python \
  qmk \
  rbenv \
  ripgrep \
  ruby-build \
  sqlite \
  starship \
  tmux \
  unibilium \
  xz \
  yq \
  || echo 'brew install failed, continuing' >&2

[ $OSTYPE != "msys" ] && source ./linktohome.sh

# macos
if [[ $OSTYPE =~ ^darwin ]]; then
  brew install \
    bash \
    bluetoothconnector \
    coreutils \
    discord \
    ffmpeg \
    gettext \
    git-secrets \
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

  brew install --cask \
    1password \
    1password-cli \
    alacritty \
    chatgpt \
    docker \
    figma \
    google-chrome \
    istat-menus@6 \
    karabiner-elements \
    notion \
    obs \
    obsidian \
    raycast \
    slack \
    visual-studio-code \
    || echo 'brew install failed, continuing' >&2

  # fonts
  brew install --cask \
    font-fira-code-nerd-font \
    font-fira-mono-nerd-font \
    font-noto-sans-cjk-jp \
    || echo 'brew install failed, continuing' >&2

  # mas
  #mas install 497799835  # Xcode

  # defaults
  $DOTFILES_DIR/mac/defaults.sh
fi

# fish
readonly FISH_PATH=$(brew --prefix)/bin/fish
if [ -f $FISH_PATH ]; then
  grep -x $FISH_PATH /etc/shells || sudo sh -c "echo $FISH_PATH >> /etc/shells"
  if [ $SHELL != $(which fish) ]; then
    chsh -s $FISH_PATH
  fi
  fish -c "source $DOTFILES_DIR/dotconfig/fish/abbr.fish"
  [ $OSTYPE = "linux-gnu" ] && fish -c "source $DOTFILES_DIR/fish_universal/linuxbrew.fish"
fi

# fzf
readonly FZF_INSTALL_PATH=$(brew --prefix)/opt/fzf/install
if [ -f $FZF_INSTALL_PATH ]; then
  $FZF_INSTALL_PATH --all --no-bash --no-zsh
fi

# bin directory
mkdir -p $HOME/bin
fish -c 'contains $HOME/bin $fish_user_paths; or fish_add_path $HOME/bin'

# pipx
type pipx > /dev/null 2>&1 && pipx install pip-review
type pipx > /dev/null 2>&1 && pipx install Send2Trash

# tpm
TPM_DIR=$HOME/.cache/tmux/plugins/tpm
[[ -d $TPM_DIR ]] || git clone https://github.com/tmux-plugins/tpm.git $TPM_DIR

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
