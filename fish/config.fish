set DOTFILES_DIR $HOME/.dotfiles
set SUBMODULES $DOTFILES_DIR/submodules
set fish_greeting ''

function myfunc_log
  if test VERBOSE = "true"
    echo -e "\e[0;32m"(gdate '+%Y/%m/%d %H:%M:%S.%N' || date '+%Y/%m/%d %H:%M:%S')" $argv\e[m"
  end
end

function myfunc_err
  if test VERBOSE = "true"
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
    set PATH $HOME/Library/Python/3.9/bin $PATH
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
    set PATH $HOME/go/bin $PATH
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
    brew update && brew upgrade && brew upgrade --cask
    type gem
    gem update
    npm update -g
    pip-review --auto
    fisher update
  end

  # aliases
  abbr l ls -lhav
  abbr d cd

  abbr tm 'tmux attach || tmux'

  abbr h fzf_history
  abbr fgq fzf_ghq_cd
  abbr j fzf_z_jump
  abbr kga fzf_kubectl_get_all

  abbr cmpo docker-compose
  abbr k kubectl
  abbr dpsa docker ps -a

  abbr tjq "jq -c '.time |= (./1000|todate)'"

  abbr gs   git status -sb
  abbr gb   git branch -v
  abbr gba  git branch -av
  abbr ga   git add
  abbr gap  git add -p
  abbr gc   git commit -v
  abbr gca  git commit -va
  abbr gd   git diff
  abbr gdc  git diff --cached
  abbr gf   git fetch --prune
  abbr gl   git log --graph --oneline --decorate
  abbr gla  git log --graph --all --oneline --decorate
  abbr glg  git log --graph --decorate --format=fuller
  abbr glga git log --graph --all --decorate --format=fuller
  abbr glp  git log --graph --decorate -p
  abbr gpl  git pull
  abbr gps  git push
  abbr gr   git remote -v
  abbr gbs  fzf_git_switch_branch
  abbr gbsa fzf_git_switch_branch --all
  abbr gbd  fzf_git_delete_branch
end
