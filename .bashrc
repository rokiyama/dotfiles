# bash options
shopt -s histappend
shopt -s autocd
shopt -s globstar

XDG_CONFIG_HOME=~/.config
DOTFILES_DIR=~/.dotfiles
EXTERNALS_DIR=$DOTFILES_DIR/externals

function source_any_if_exists() {
  local filepaths=$*
  for f in ${filepaths[@]}; do
    if [[ -f $f ]]; then
      source $f
      return 0
    fi
  done
  return 1
}

source_any_if_exists /usr/local/etc/bash_completion \
                     /usr/share/bash-completion/bash_completion

# git-prompt
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_THEME=Default
GIT_PROMPT_FETCH_REMOTE_STATUS=0
if [[ -d $EXTERNALS_DIR/bash-git-prompt ]]; then
  source_any_if_exists $EXTERNALS_DIR/bash-git-prompt/gitprompt.sh
else
  source_any_if_exists /usr/share/git/completion/git-prompt.sh \
                       /usr/local/src/git-2.17.0/contrib/completion/git-prompt.sh \
                       /mingw64/share/git/completion/git-prompt.sh
fi

# git-completion
if type brew >/dev/null 2>&1; then
  source_any_if_exists $(brew --prefix)/opt/git/etc/bash_completion.d/git-completion.bash
else
  source_any_if_exists /usr/share/git/completion/git-completion.bash \
                       /usr/local/src/git-2.17.0/contrib/completion/git-completion.bash \
                       /mingw64/share/git/completion/git-completion.bash
fi

# vagrant
if type vagrant.exe >/dev/null 2>&1; then
  source_any_if_exists $(find $(dirname $(which vagrant.exe))/.. -name 'bash' -type d | head -n 1)/completion.sh
fi

# brew
if type "brew" > /dev/null 2>&1; then
  source_any_if_exists "$(brew --prefix)/etc/bash_completion"
  source_any_if_exists "$(brew --prefix)/share/gitprompt.sh"
  source_any_if_exists "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
  source_any_if_exists "$(brew --prefix)/Cellar/docker/18.04.0/etc/bash_completion.d/docker"
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  if [ -f $(brew --prefix)/etc/brew-wrap ];then
    source $(brew --prefix)/etc/brew-wrap
  fi
  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
    source "$completion_file"
  done
  export HOMEBREW_BREWFILE=~/.dotfiles/Brewfile
  export HOMEBREW_BREWFILE_ON_REQUEST=1
fi

# prompt
if type __git_ps1 >/dev/null 2>&1; then
  PS1='[\u@\h \w`__git_ps1 " (%s)"`]\n$(date +%H:%M) \$ '
else
  PS1='[\u@\h \w]\n$(date +%H:%M) \$ '
fi

# linuxbrew
[[ -d /home/linuxbrew/.linuxbrew ]] && export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

# rbenv
[[ -d $HOME/.rbenv ]] && export PATH="$HOME/.rbenv/bin:$PATH"
if type rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
  source_any_if_exists $(rbenv root)/completions/rbenv.bash
fi
source_any_if_exists $EXTERNALS_DIR/completion-ruby/completion-ruby-all

# go
[[ -d $HOME/go ]] && export PATH="$HOME/go/bin:$PATH"

# ghq & peco
if type ghq peco >/dev/null 2>&1; then
  function g() {
    local readonly repos=$(ghq list | peco)
    if [[ -n $repos ]]; then
      cd $(ghq root)/$repos
    else
      echo 'Canceled.'
    fi
  }
fi

# nvm
NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
source_any_if_exists $(brew --prefix)/opt/nvm/nvm.sh
source_any_if_exists $(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm

# aliases
alias ls='ls --color=auto'
alias t='ls -lhtr'
alias l='ls -lhav'
alias a='ls -av'
alias f=ls
alias d=cd

alias grep='grep --color=auto'

alias hisg='history | grep'
alias tm='tmux attach || tmux'

alias gst='git status -s -b; printf "[user]\n$(git config --local -l | grep user || git config --global -l | grep user || printf unspecified)\n"'

if [ "$OSTYPE" = 'msys' ] && type vagrant.exe >/dev/null 2>&1; then
  alias vagrant='vagrant.exe'
fi

if type nvim >/dev/null 2>&1; then
  alias vim=nvim
fi

[[ -d $EXTERNALS_DIR/dircolors-solarized ]] && eval `dircolors $EXTERNALS_DIR/dircolors-solarized/dircolors.ansi-universal`

if [ -f ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi
