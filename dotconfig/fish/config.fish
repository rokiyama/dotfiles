set fish_greeting ''

if [ -f /opt/homebrew/bin/brew ]
  eval (/opt/homebrew/bin/brew shellenv)
end

if [ -f ~/.local/private_functions.fish ]
  source ~/.local/private_functions.fish
end

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

  # nvim
  if type nvim > /dev/null 2>&1
    myfunc_log 'nvim is installed'
    alias vimdiff='nvim -d'
  else
    myfunc_err 'nvim is not installed.'
  end

  # fzf
  if type fzf > /dev/null 2>&1
    myfunc_log 'fzf is installed'
    set FZF_CMD fzf
    set -ax FZF_DEFAULT_OPTS "--tiebreak=index"
    set -ax FZF_DEFAULT_OPTS "--toggle-sort=ctrl-r"

    # fzf git
    function fzf_git_switch_branch
      git branch -v $argv | grep -v '^\+' | $FZF_CMD --tac | sed 's/^[\*\+]//' | read -l result _
      if [ -z $result ]
        return
      end
      if string match 'remotes/*' $result
        set -l branch_name (string replace -r '^remotes/[[:alnum:]]*/?' '' $result)
        eval "git switch $branch_name"
      else
        eval "git switch $result"
      end
    end

    function fzf_git_delete_branch
      set -l result (git branch -v | $FZF_CMD --tac --multi | sed 's/^[\*\+]//' | awk '{print $1}')
      if [ (count $result) -eq 0 ]
        return
      end
      commandline 'git branch -d '(string join ' ' $result)
    end

    function fzf_git_cd_worktree
      git worktree list | $FZF_CMD --tac | read -l result
      echo $result | sed 's/^[\*\+]//' | read -l path _
      if [ -z $path ]
        echo "No worktree selected"
      else
        echo $result
        eval "cd $path"
      end
    end

    # ghq
    if type ghq > /dev/null 2>&1
      myfunc_log 'ghq is installed'
      function fzf_ghq_cd
        ghq list | $FZF_CMD | read -l result && cd (ghq root)"/$result"
      end
    else
      myfunc_err 'ghq is not installed.'
    end

    # z
    if type z > /dev/null 2>&1
      myfunc_log 'z is installed'
      function fzf_z_jump
        # TODO: スペースのあるパスで正しく動作しない
        z --list | $FZF_CMD | read -l _ result _ && cd "$result"
      end
    else
      myfunc_err 'z is not installed.'
    end
  end

  # kubectl
  if type kubectl > /dev/null 2>&1
    myfunc_log 'kubectl is installed'
    function fzf_kubectl_get_all
      set -l target $argv[1]
      if [ -z $target ]
        set target "pod"
      end
      kubectl get $target -A | $FZF_CMD --header-lines=1 | read -l ns name _ && commandline "kubectl get $target -n $ns $name"
    end
    function fzf_kubectl_port_forward
      kubectl get svc -A | $FZF_CMD --header-lines=1 | read -l ns name _ _ _ port _ && commandline "kubectl port-forward -n $ns svc/$name "(echo $port | cut -d'/' -f1)
    end
  else
    myfunc_err 'kubectl is not installed.'
  end

  # paths
  if [ -d $HOME/.local/bin ]
    fish_add_path $HOME/.local/bin
  end

  # utility functions
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

  function git_add_worktree
    set -l branch $argv[1]
    if [ -z $branch ]
      return
    end
    # create a new branch
    git worktree add .wt/$branch -b $branch && \
      cd (git rev-parse --show-toplevel)/.wt/$branch
  end
end

source $HOME/.config/fish/abbr.fish

source $HOME/.config/op/plugins.sh
