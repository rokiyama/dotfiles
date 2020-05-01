function load_fzf
  if ! type fzf > /dev/null
    myfunc_err 'fzf is not installed.'
    return
  end

  myfunc_log 'fzf is installed'
  set -a FZF_DEFAULT_OPTS "--tiebreak=index"
  set -a FZF_DEFAULT_OPTS "--toggle-sort=ctrl-r"
  set -a FZF_DEFAULT_OPTS "--query=(commandline)"

  # git
  function fzf_git_switch_branch
    git branch -v $argv | fzf-tmux $FZF_DEFAULT_OPTS | sed 's/^\*//' | read -l result _
    if [ -z $result ]
      return
    end
    if string match 'remotes/*' $result
      set -l branch_name (string replace -r '^remotes/' '' $result)
      set -l local_branch_name (string replace -r '^remotes/[[:alnum:]]*/?' '' $result)
      commandline "git switch -c $local_branch_name $branch_name"
    else
      commandline "git switch $result"
    end
  end

  function fzf_git_delete_branch
    git branch -v | fzf-tmux $FZF_DEFAULT_OPTS | sed 's/^\*//' | read -l result _ && commandline "git b -d $result"
  end

  # ghq
  if type ghq > /dev/null
    myfunc_log 'ghq is installed'
    function fzf_ghq_cd
      ghq list | fzf-tmux $FZF_DEFAULT_OPTS | read -l result && cd (ghq root)"/$result"
    end
  else
    myfunc_err 'ghq is not installed.'
  end

  # z
  if type z > /dev/null
    myfunc_log 'z is installed'
    function fzf_z_jump
      # TODO: スペースのあるパスで正しく動作しない
      z --list | fzf-tmux $FZF_DEFAULT_OPTS | read -l _ result _ && cd "$result"
    end
  else
    myfunc_err 'z is not installed.'
  end

  # kubectl
  if type kubectl > /dev/null
    myfunc_log 'kubectl is installed'
    function fzf_kubectl_get_all
      set -l target $argv[1]
      if [ -z $target ]
        set target "pod"
      end
      kubectl get $target -A | fzf-tmux $FZF_DEFAULT_OPTS --header-lines=1 | read -l ns pod _ && commandline "kubectl get pod -n $ns $pod"
    end
  else
    myfunc_err 'kubectl is not installed.'
  end
end

load_fzf
