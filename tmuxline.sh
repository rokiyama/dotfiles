#!/bin/sh
set -eu

readonly date=$(date)
readonly global_ip_addr=$(curl ifconfig.me)

tmux set -g status-justify "left"
tmux set -g status "on"
tmux set -g status-left-style "none"
tmux set -g message-command-style "fg=colour252,bg=colour240"
tmux set -g status-right-style "none"
tmux set -g pane-active-border-style "fg=colour117"
tmux set -g status-style "none,bg=colour238"
tmux set -g message-style "fg=colour252,bg=colour240"
tmux set -g pane-border-style "fg=colour240"
tmux set -g status-right-length "100"
tmux set -g status-left-length "100"
tmux setw -g window-status-activity-style "none"
tmux setw -g window-status-separator ""
tmux setw -g window-status-style "none,fg=colour248,bg=colour238"
tmux set -g status-left "#[fg=colour238,bg=colour117] #S #[fg=colour117,bg=colour238,nobold,nounderscore,noitalics]"
tmux set -g status-right "#{prefix_highlight}#[fg=colour240,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour247,bg=colour240] #(ipconfig getifaddr en0)  ${global_ip_addr} "
tmux setw -g window-status-format "#[fg=colour248,bg=colour238] #I #[fg=colour248,bg=colour238] #W "
tmux setw -g window-status-current-format "#[fg=colour238,bg=colour240,nobold,nounderscore,noitalics]#[fg=colour252,bg=colour240] #I #[fg=colour252,bg=colour240] #W #[fg=colour240,bg=colour238,nobold,nounderscore,noitalics]"
