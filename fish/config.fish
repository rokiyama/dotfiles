set DOTFILES_DIR $HOME/.dotfiles
set SUBMODULES $DOTFILES_DIR/submodules

function myfunc_log
  echo -e "\e[0;32m"(date '+%Y/%m/%d %H:%M:%S.%N')" $argv\e[m"
end

function myfunc_err
  echo -e "\e[0;31m"(date '+%Y/%m/%d %H:%M:%S.%N')" $argv\e[m"
end

if status is-interactive
  # Fisher
  if not functions -q fisher
    myfunc_log 'Installing fisher for the first time...'
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
  end

  # brew
  if type brew > /dev/null
    myfunc_log 'brew is installed'
    set -x HOMEBREW_BREWFILE $HOME/.dotfiles/Brewfile
    set -x HOMEBREW_BREWFILE_ON_REQUEST 1
    set -x HOMEBREW_BREWFILE_APPSTORE 0
    set PATH (brew --prefix coreutils)"/libexec/gnubin" $PATH
    myfunc_log "brew is ok"

    # nvm
    if functions -q nvm
      myfunc_log 'nvm is installed'
      set -x NVM_DIR "$HOME/.nvm"
      set -x nvm_prefix "$HOME/.nvm"
      nvm use default
    else
      myfunc_err 'nvm is not installed.'
    end
  else
    myfunc_err 'brew is not installed.'
  end

  # powerline
  if type powerline > /dev/null
    myfunc_log 'powerline is installed, loading fish bindings...'
    set powerline_status_location (pip3 show powerline-status | grep 'Location: ' | cut -d' ' -f 2)
    set fish_function_path $fish_function_path "$powerline_status_location/powerline/bindings/fish"
    powerline-setup

    # powerline for tmux
    if [ -n "$TMUX" ]
      myfunc_log 'powerline is installed and in tmux, loading tmux bindings...'
      tmux source "$powerline_status_location/powerline/bindings/tmux/powerline.conf"
    else
      myfunc_log 'not in tmux'
      powerline-daemon -q
    end
  else
    myfunc_err 'powerline is not installed.'
  end

  # rbenv
  if type rbenv > /dev/null
    myfunc_log 'rbenv is installed'
    source (rbenv init - | psub)
  else
    myfunc_err 'rbenv is not installed.'
  end

  # go
  if type go > /dev/null; and [ -d $HOME/go ]
    myfunc_log 'go is installed'
    set PATH $HOME/go/bin $PATH
  else
    myfunc_err 'go is not installed.'
  end

  # jenv
  if type jenv > /dev/null
    myfunc_log 'jenv is installed'
    source (brew --prefix)/opt/jenv/libexec/fish/export.fish
    source (brew --prefix)/opt/jenv/libexec/fish/jenv.fish
  end

  source $DOTFILES_DIR/fish/fzf.fish

  # dircolors
  if [ -d $SUBMODULES/dircolors-solarized ]
    myfunc_log 'dircolors-solarized is installed'
    eval (dircolors -c $SUBMODULES/dircolors-solarized/dircolors.ansi-universal)
  else
    myfunc_err 'dircolors-solarized is not installed.'
  end

  # aliases
  alias ls='ls --color=auto'
  alias t='ls -lhtr'
  alias l='ls -lhav'
  alias a='ls -av'
  alias f=ls
  alias d=cd

  alias grep='grep --color=auto'

  alias tm='tmux attach; or tmux'

  alias gst='git status -s -b; echo "[user]"; git config --local -l | grep user; or git config --global -l | grep user; or printf unspecified'
  alias gbs='git_switch_branch'
  alias gbsa='git_switch_branch --all'
  alias gbd='git_delete_branch'

  alias cmpo='docker-compose'
  alias k='kubectl'

  # nvim
  if type nvim > /dev/null
    myfunc_log 'nvim is installed'
    alias vimdiff='nvim -d'
  else
    myfunc_err 'nvim is not installed.'
  end

  if [ -d $HOME/.local/bin ]
    set PATH $HOME/.local/bin $PATH
  end

  function posix-source
    for i in (cat $argv)
      set arr (echo $i |tr = \n)
      set -gx $arr[1] $arr[2]
    end
  end

  function list-outdated-packages
    brew update && brew outdated
    brew cask outdated
    gem outdated
    npm outdated -g
    pip-review
  end

  function upgrade-packages
    brew update; and brew upgrade
    brew cask upgrade
    gem update
    npm update -g
    pip-review --auto
    fisher self-update
    fisher
  end

  function jqe
    echo $argv[1] | jq $argv[2]
  end
end
