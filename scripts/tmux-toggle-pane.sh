#!/usr/bin/env bash

# Parameters
# $1: The name of the tmux user option to store the pane ID (default: toggablepane)
# $2: The split dimensions/flags (default: "-v -f -l 20%")
# $3: The shell command to send to the new pane (default: "")


OPTION_NAME="${1:-toggablepane}"
LAYOUT_OPTION="@${OPTION_NAME}_layout"

SPLIT_ARGS="${2:- -v -f -l 20%}"
SHELL_COMMAND="${3:-}"

# where to store the pane when hidden
SCRATCH_SESSION="scratch"

# retrieve the specific pane id for this toggle name
P=$(tmux show -swqv "@${OPTION_NAME}")

# check if pane exists in current window
if [ -n "$P" ] && tmux lsp -F'#{pane_id}' | grep -q "^${P}$"; then

    # ensure scratch session exists
    if ! tmux has-session -t "$SCRATCH_SESSION" 2>/dev/null; then
        tmux new-session -d -s "$SCRATCH_SESSION"
    fi

    # hide it: send to scratch session
    # using break-pane to move it to its own window in the background
    tmux break-pane -d -s "$P" -t "${SCRATCH_SESSION}:"

    # restore original layout
    SAVED_LAYOUT=$(tmux show -swqv "$LAYOUT_OPTION")
    if [ -n "$SAVED_LAYOUT" ]; then
        tmux select-layout "$SAVED_LAYOUT"
    fi
else
    # save current layout before we mess with it
    CURRENT_LAYOUT=$(tmux display-message -p '#{window_layout}')
    tmux set -sw "$LAYOUT_OPTION" "$CURRENT_LAYOUT"
    # check if it exists anywhere else (e.g., in scratch)
    if [ -n "$P" ] && tmux list-panes -a -F "#{pane_id}" | grep -q "^${P}$"; then
        # bring it back to current window with specified dimensions
        # move-pane is the correct command for bringing a pane from another session
        tmux move-pane ${SPLIT_ARGS} -d -s "$P" -t ":"
    else
        # create the pane if it doesn't exist anywhere
        # splitw -P returns the new pane ID
        # P=$(tmux splitw ${SPLIT_ARGS} -PF'#{pane_id}')
        if [ -n "$SHELL_COMMAND" ]; then
            P=$(tmux splitw ${SPLIT_ARGS} -PF'#{pane_id}' "$SHELL_COMMAND")
        else
            P=$(tmux splitw ${SPLIT_ARGS} -PF'#{pane_id}')
        fi
        tmux set -sw "@${OPTION_NAME}" "$P"
    fi
    tmux select-pane -t "$P"
fi
