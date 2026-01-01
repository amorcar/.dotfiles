#!/usr/bin/env bash

SCRATCH_SESSION="scratch"
# SCRATCH_WINDOW="toggable"
P=$(tmux show -swqv @toggablepane)

# check if pane exists in current window
if [ -n "$P" ] && tmux lsp -F'#{pane_id}' | grep -q ^"$P"; then

    # check if scratch session exists, create it if not
    if ! ( tmux list-session -F "#{session_name}" | grep -q "$SCRATCH_SESSION" ); then
      tmux new-session -d -s "$SCRATCH_SESSION"
    fi

     # check if scratch:toggable exists, create it if not
     # if ! ( tmux list-windows -t "$SCRATCH_SESSION" | grep -q "$SCRATCH_WINDOW" ); then
     #    tmux new-window -t "$SCRATCH_SESSION" -n toggable
     # fi

     # send to scratch:toggable
      # tmux move-pane -d -s "$P" -t "$SCRATCH_SESSION:$SCRATCH_WINDOW"
      tmux break-pane -d -s "$P" -t "$SCRATCH_SESSION"
else
    # if doesnt exist in current session, check if it exists at all somewhere
    # could also use ```-s -F "#{pane_id}" -t "$SCRATCH_SESSION"``` to check if its in scratch
    if [ -n "$P" ] && tmux list-panes -a -F "#{pane_id}" | grep -q "^${P}"; then
        # if pane exists in scratch, bring it here
        tmux move-pane -v -f -l 20% -d -s "$P" -t ":"
    else
        # else, create the pane
        P=$(tmux splitw -v -f -l 20% -PF'#{pane_id}')
        tmux set -sw @toggablepane "$P"
    fi
    tmux select-pane -t "$P"
fi


