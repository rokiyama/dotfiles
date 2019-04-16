# dotfiles

## Setup

    curl -sSLo- https://raw.githubusercontent.com/rokiyama/dotfiles/master/init.sh | sh

## Update submodules

    git submodule update

## memo

    # set git username
    git config --local user.name rokiyama; and git config --local user.email '49217895+rokiyama@users.noreply.github.com'

    # install neovim
    sudo apt-add-repository -y ppa:neovim-ppa/unstable; and sudo apt update; and sudo apt install -y neovim python3-neovim; and sudo apt remove -y vim
