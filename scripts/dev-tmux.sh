#!/bin/sh
#
# Setup a work space called `work` with two windows
# first window has 3 panes. 
# The first pane set at 65%, split horizontally, set to api root and running vim
# pane 2 is split at 25% and running redis-server 
# pane 3 is set to api root and bash prompt.
# note: `api` aliased to `cd ~/path/to/work`
#

session="MBP"
wd="~/"

# set up tmux
# tmux start-server

# create a new tmux session, starting nvim from a saved session in the new window
tmux attach-session -t $session && exit 1 || tmux new-session -d -s $session -n main -x "$(tput cols)" -y "$(tput lines)"

# tmux new-session -d -s $session -n main -x "$(tput cols)" -y "$(tput lines)"

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
# tmux send-keys "cd " $wd C-m
# tmux send-keys nvim C-m

# Select pane 2
tmux select-pane -t 1
tmux clock -t 1
# tmux send-keys "date & cal" C-m

# select pane 3
tmux select-pane -t 2
# tmux send-keys "neofetch" C-m

# Select pane 1
tmux select-pane -t 0
# tmux send-keys "neofetch" C-m

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
