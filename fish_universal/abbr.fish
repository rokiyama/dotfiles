# delete all
abbr -e (abbr -l)

abbr l ls -lhav
abbr d cd

abbr tm 'tmux attach || tmux'

abbr h fzf_history
abbr fgq fzf_ghq_cd
abbr j fzf_z_jump
abbr kga fzf_kubectl_get_all

abbr cmpo docker compose
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

abbr gcd  git 'status >/dev/null && cd (git rev-parse --show-toplevel)'
