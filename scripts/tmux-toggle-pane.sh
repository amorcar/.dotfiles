#!/usr/bin/env bash

# Parameters
# $1: The name of the tmux user option to store the pane ID (e.g., "mytoggle")
# $2: The split dimensions/flags (default: "-v -f -l 20%")
OPTION_NAME="${1:-toggablepane}"
SPLIT_ARGS="${2:- -v -f -l 20%}"
SCRATCH_SESSION="scratch"

# Retrieve the specific pane ID for this toggle name
P=$(tmux show -swqv "@${OPTION_NAME}")

# 1. Check if pane exists in current window
if [ -n "$P" ] && tmux lsp -F'#{pane_id}' | grep -q "^${P}$"; then

    # Ensure scratch session exists
    if ! tmux has-session -t "$SCRATCH_SESSION" 2>/dev/null; then
        tmux new-session -d -s "$SCRATCH_SESSION"
    fi

    # Hide it: send to scratch session
    # We use break-pane to move it to its own window in the background
    tmux break-pane -d -s "$P" -t "${SCRATCH_SESSION}:"
else
    # 2. Check if it exists anywhere else (e.g., in scratch)
    if [ -n "$P" ] && tmux list-panes -a -F "#{pane_id}" | grep -q "^${P}$"; then
        # Bring it back to current window with specified dimensions
        # move-pane is the correct command for bringing a pane from another session
        tmux move-pane ${SPLIT_ARGS} -d -s "$P" -t ":"
    else
        # 3. Create the pane if it doesn't exist anywhere
        # splitw -P returns the new pane ID
        P=$(tmux splitw ${SPLIT_ARGS} -PF'#{pane_id}')
        tmux set -sw "@${OPTION_NAME}" "$P"
    fi
    tmux select-pane -t "$P"
fi
