# dotfiles

## Setup

```sh
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# init
curl -sSLo- https://raw.githubusercontent.com/rokiyama/dotfiles/master/init.sh | bash
```

## Update submodules

```sh
git submodule update
```

## memo

```sh
# set git username
git config --local user.name rokiyama && git config --local user.email '57606749+rokiyama@users.noreply.github.com'

set -l USERNAME rokiyama && set -l USEREMAIL 57606749+rokiyama@users.noreply.github.com && git filter-branch -f --env-filter "GIT_AUTHOR_NAME='$USERNAME'; GIT_AUTHOR_EMAIL='$USEREMAIL'; GIT_COMMITTER_NAME='$USERNAME'; GIT_COMMITTER_EMAIL='$USEREMAIL';" HEAD

# install neovim (on debian)
sudo apt-add-repository -y ppa:neovim-ppa/unstable && sudo apt update && sudo apt install -y neovim python3-neovim && sudo apt remove -y vim
```
