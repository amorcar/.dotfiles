#!/bin/sh

session="main"
wd="~/"

# create a new tmux session, starting nvim from a saved session in the new window
tmux attach-session -t $session && exit 1 || tmux new-session -d -s $session -n main -x "$(tput cols)" -y "$(tput lines)"
# Split pane 1 horizontal by 65%
tmux splitw -h -p 30
# Split pane 2 vertiacally by 25%
tmux splitw -v -p 75
# create a new window called scratch
tmux new-window -n scratch
# return to main nvim window
tmux select-window -t 1
# Select pane 1, run nvim
tmux select-pane -t 0
# Select pane 2
tmux select-pane -t 1
tmux clock -t 1
# select pane 3
tmux select-pane -t 2
# Select pane 1
tmux select-pane -t 0
# Finished setup, attach to the tmux session!
tmux attach-session -t $session
