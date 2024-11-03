#!/usr/bin/env bash

# Script to create + attach or switch to an existing tmux session
function tmuxOpen {
    if [[ -z $TMUX ]] ; then
        tmux attach -t "$1"
    else
        tmux switch-client -t "$1"
    fi
    exit 0
}

function main {

    local sessions
    local sess_arr
    local retval

    local session
    local query

    TMUX_SERVER=$(pgrep tmux)

    if [[ -z $TMUX_SERVER ]] ; then
        sessions=$(echo "" | fzf --exit-0 --print-query --reverse)
        retval=$?
    else
        current_session=$(tmux display-message -p '#S')

        if [[ "$current_session" == "work" ]]; then
            reverse=true
        fi
        sessions=$( \
          tmux list-sessions -F "#{session_name}" |\
          awk '!/org/{ print $0 }' |\
          fzf \
          --exit-0 \
          --print-query \
          --pointer '*' \
          --color='current-bg:-1' \
          --cycle \
          --border none \
          --no-scrollbar \
          --no-separator \
          --no-info \
          ${reverse:+--tac}
        )
        retval=$?
    fi

    IFS=$'\n' read -rd '' -a sess_arr <<<"$sessions"

    session=${sess_arr[1]}
    query=${sess_arr[0]}

    if [[ $retval == 0 ]]; then
        if [[ "$session" == "" ]]; then
            session="$query"
        fi
        printf "Switching to existing tmux session named [$session]\n"
    else
        if [[ -z "$query" ]]; then
            printf "Invalid session name \"$query\"\nExiting.\n"
            exit 1
        fi
        session="$query"
        printf "Creating new tmux session named [$session] and attaching\n"
        tmux new-session -d -s "$session"
    fi
    tmuxOpen "$session"
}
main

