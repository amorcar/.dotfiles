#!/usr/bin/env bash

SCRATCH_SESSION="scratch"
SCRATCH_WINDOW="toggable"
P=$(tmux show -swqv @toggablepane)

# if pane exists in current session, move it to scratch
if [ -n "$P" ] && tmux lsp -F'#{pane_id}'|grep -q ^"$P"; then
     # tmux killp -t"$P"

     # send to scratch:toggable window if exists. If not create it first
     if ! ( tmux list-windows -t "$SCRATCH_SESSION" | grep -q "$SCRATCH_WINDOW" ); then
        tmux new-window -t "$SCRATCH_SESSION" -n toggable
     fi
      tmux move-pane -d -s "$P" -t "$SCRATCH_SESSION:$SCRATCH_WINDOW"
     # tmux set -wu @toggablepane
else
  # if doesnt exist in current session, check if it exists in scratch session
  # if [ -n "$P" ] && tmux list-panes -s -F "#{pane_id}" -t "$SCRATCH_SESSION" | grep -q "^${P}"; then
  # if doesnt exist in current session, check if it exists at all somewhere
  if [ -n "$P" ] && tmux list-panes -a -F "#{pane_id}" | grep -q "^${P}"; then
    # if pane exists in scratch, bring it here
    tmux move-pane -v -f -l 20% -d -s "$P" -t ":"
  # else, create the pane
  else
     P=$(tmux splitw -v -f -l 20% -PF'#{pane_id}')
     tmux set -sw @toggablepane "$P"
  fi
  tmux select-pane -t "$P"
fi


