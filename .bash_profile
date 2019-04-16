HISTCONTROL=ignorespace,erasedups
HISTFILE=~/.bash_history
HISTFILESIZE=30000

[[ -s ${HOME}/.bash_profile_local ]] && source ${HOME}/.bash_profile_local
[[ -s ${HOME}/.bashrc ]] && source ${HOME}/.bashrc

# GoLang
if type go >/dev/null 2>&1; then
  export PATH=$PATH:/usr/local/go/bin
fi
