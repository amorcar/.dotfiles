#!/bin/sh
SESSION_NAME="work"
WORKING_DIR="$HOME/Work/git/pipeliner/"
VENV_PATH="$HOME/Library/Caches/pypoetry/virtualenvs/pipeliner-_koFisC3-py3.11/bin/activate.fish"
ENV_FILE="$WORKING_DIR/.env"

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
  # tmux rename-window -t $SESSION_NAME:1 'main'
  tmux split-window -h -t $SESSION_NAME:1.0 -l 40%
  tmux split-window -v -t $SESSION_NAME:1.1 -l 20%

  # Second window setup
  tmux new-window -t $SESSION_NAME:2 # 'db'
  tmux split-window -h -t $SESSION_NAME:2

  tmux set-window-option -t $SESSION_NAME:1 synchronize-panes on
  tmux send-keys -t $SESSION_NAME:1 "cd $WORKING_DIR" C-m
  tmux send-keys -t $SESSION_NAME:1 ". (sed 's/^/export /' $ENV_FILE | psub) > /dev/null" C-m
  tmux send-keys -t $SESSION_NAME:1 ". $VENV_PATH" C-m
  tmux set-window-option -t $SESSION_NAME:1 synchronize-panes off

  tmux set-window-option -t $SESSION_NAME:2 synchronize-panes on
  tmux send-keys -t $SESSION_NAME:2 "cd $WORKING_DIR" C-m
  tmux send-keys -t $SESSION_NAME:2 ". (sed 's/^/export /' $ENV_FILE | psub) > /dev/null" C-m
  tmux send-keys -t $SESSION_NAME:2 ". $VENV_PATH" C-m
  tmux set-window-option -t $SESSION_NAME:2 synchronize-panes off

  tmux send-keys -t $SESSION_NAME:2.0 "clear" C-m
  tmux send-keys -t $SESSION_NAME:2.1 "clear" C-m

  tmux select-window -t 2
  tmux select-pane -t 0

  tmux send-keys -t $SESSION_NAME:1.0 "nvim -c 'Telescope oldfiles'" C-m
  tmux send-keys -t $SESSION_NAME:1.1 "ipython" C-m c-l
  tmux send-keys -t $SESSION_NAME:1.2 "clear" C-m

  tmux select-window -t 1
  tmux select-pane -t 1
  tmux select-pane -t 0

  # Attach to the session
  if [[ $1 == attach ]]; then
    tmux attach-session -t $SESSION_NAME
  fi

fi
