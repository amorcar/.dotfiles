#!/bin/sh

session="main"
wd="~/"

# create a new tmux session, starting nvim from a saved session in the new window
tmux attach-session -t $session && exit 1 || tmux new-session -d -s $session -n main -x "$(tput cols)" -y "$(tput lines)"

tmux splitw -h -p 30
tmux splitw -v -p 75
tmux new-window -n scratch
tmux select-window -t 1
tmux select-pane -t 0
tmux splitw -v -p 15
tmux clock -t 2
tmux select-pane -t 0

# Finished setup, attach to the tmux session!
tmux attach-session -t $session



# Common commands
# tmux new-window -n window_name
# tmux splitw -h/v -p 30
# tmux select-pane -t 0
# tmux select-window -t 0
# tmux send-keys -p 0 "ls -lha" C-m
