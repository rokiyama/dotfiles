# dotfiles

## Setup

    curl -sSLo- https://raw.githubusercontent.com/rokiyama/dotfiles/master/init.sh | sh

## Update submodules

    git submodule update

## memo

    # set git username
    git config --local user.name rokiyama && git config --local user.email '49217895+rokiyama@users.noreply.github.com'

    # install neovim (on debian)
    sudo apt-add-repository -y ppa:neovim-ppa/unstable && sudo apt update && sudo apt install -y neovim python3-neovim && sudo apt remove -y vim

    # set LC_ALL (mac)
    ln -s $HOME/.dotfiles/mac/setenv.LC_ALL.plist $HOME/Library/LaunchAgents/
    launchctl load $HOME/Library/LaunchAgents/setenv.LC_ALL.plist
