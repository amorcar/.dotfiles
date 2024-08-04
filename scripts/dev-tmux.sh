#!/bin/sh
SESSION_NAME="main"
WORKING_DIR="$HOME/Dev/projects/tsp/"
VENV_PATH=".venv/bin/activate.fish"

# Check if the session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "$SESSION_NAME session exists"
    if [[ $1 == attach ]]; then
      tmux attach-session -t $SESSION_NAME
    fi
else
  # Create the tmux session
  tmux new-session -d -s $SESSION_NAME

  # First window setup
  tmux rename-window -t $SESSION_NAME:1 'home'
  tmux split-window -h -t $SESSION_NAME:1.0 -l 40%
  tmux split-window -v -t $SESSION_NAME:1.1 -l 10%

  tmux set-window-option -t $SESSION_NAME:1 synchronize-panes on
  tmux send-keys -t $SESSION_NAME:1 "cd $WORKING_DIR" C-m
  tmux send-keys -t $SESSION_NAME:1 ". $VENV_PATH" C-m
  tmux set-window-option -t $SESSION_NAME:1 synchronize-panes off

  tmux send-keys -t $SESSION_NAME:1.0 "clear" C-m
  tmux send-keys -t $SESSION_NAME:1.0 "nvim -c 'Telescope oldfiles'" C-m
  tmux send-keys -t $SESSION_NAME:1.1 "clear" C-m
  tmux send-keys -t $SESSION_NAME:1.2 "clear" C-m
  tmux clock -t $SESSION_NAME:1.2

  tmux select-window -t 1
  tmux select-pane -t 1
  tmux select-pane -t 0

  if [[ $1 == attach ]]; then
    tmux attach-session -t $SESSION_NAME
  fi

fi
