set DOTFILES_DIR $HOME/.dotfiles
set fish_greeting ''

function myfunc_log
  if test "$VERBOSE" = "true"
    echo -e "\e[0;32m"(gdate '+%Y/%m/%d %H:%M:%S.%N' || date '+%Y/%m/%d %H:%M:%S')" $argv\e[m"
  end
end

function myfunc_err
  if test "$VERBOSE" = "true"
    echo -e "\e[0;31m"(gdate '+%Y/%m/%d %H:%M:%S.%N' || date '+%Y/%m/%d %H:%M:%S')" $argv\e[m"
  end
end

if status is-interactive
  # Fisher
  if not functions -q fisher
    myfunc_log 'Installing fisher for the first time...'
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config
    curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
  end

  # starship
  if type starship > /dev/null 2>&1
    myfunc_log 'starship is installed'
    starship init fish | source
  else
    myfunc_err 'starship is not installed.'
  end

  # nvm
  if functions -q nvm
    myfunc_log 'nvm is installed'
    set -x NVM_DIR "$HOME/.nvm"
  else
    myfunc_err 'nvm is not installed.'
  end

  # python
  if type python3 > /dev/null 2>&1
    fish_add_path $HOME/Library/Python/3.9/bin
  end

  # rbenv
  if type rbenv > /dev/null 2>&1
    myfunc_log 'rbenv is installed'
    source (rbenv init - | psub)
  else
    myfunc_err 'rbenv is not installed.'
  end

  # go
  if type go > /dev/null 2>&1; and [ -d $HOME/go ]
    myfunc_log 'go is installed'
    fish_add_path $HOME/go/bin
  else
    myfunc_err 'go is not installed.'
  end

  # jenv
  if type jenv > /dev/null 2>&1
    myfunc_log 'jenv is installed'
    source (brew --prefix)/opt/jenv/libexec/fish/export.fish
    source (brew --prefix)/opt/jenv/libexec/fish/jenv.fish
  else
    myfunc_err 'jenv is not installed.'
  end

  source $DOTFILES_DIR/fish/fzf.fish

  # nvim
  if type nvim > /dev/null 2>&1
    myfunc_log 'nvim is installed'
    alias vimdiff='nvim -d'
  else
    myfunc_err 'nvim is not installed.'
  end

  if [ -d $HOME/.local/bin ]
    fish_add_path $HOME/.local/bin
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
    brew update && brew upgrade && brew upgrade --cask
    type gem
    gem update
    npm update -g
    pip-review --auto
    fisher update
  end
end
