# delete all
abbr -e (abbr -l)

abbr l ls -lhav
abbr d cd

abbr tm  tmux
abbr tma tmux attach
abbr tml tmux list-sessions

abbr h history
abbr hc 'history | fzf | read -l result && [ -n $result ] && echo -n $result | pbcopy && echo Copied: (pbpaste)'
abbr fgq fzf_ghq_cd
abbr j   fzf_z_jump
abbr dj  'fd --type d | fzf | read TARGET_DIR && cd $TARGET_DIR'
abbr kga fzf_kubectl_get_all

abbr cmpo docker compose
abbr k kubectl
abbr dpsa docker ps -a

abbr tjq "jq -c '.time |= (./1000|todate)"

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
abbr gcw  fzf_git_cd_worktree
abbr gw   git worktree
abbr gwl  git worktree list
abbr gwa  git_add_worktree

abbr gcd  git 'status >/dev/null && cd (git rev-parse --show-toplevel)'
abbr gtop git rev-parse --show-toplevel

abbr by   bat -l yaml
