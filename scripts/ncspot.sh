#!/bin/bash

# Usage: ./ncspot.sh song-artist|song|artist

FORMAT="$1"

json=$(echo status | nc -U /tmp/ncspot-501/ncspot.sock | head -n 1)

# only proceed if music is playing
if echo "$json" | jq -e '.mode.Playing' >/dev/null; then
    case "$FORMAT" in
        song-artist)
            echo "$json" | jq -r '"󰝚 \(.playable.title) (\(.playable.artists | join(", ")))"'
            ;;
        song)
            echo "$json" | jq -r '.playable.title'
            ;;
        artist)
            echo "$json" | jq -r '.playable.artists | join(", ")'
            ;;
        *)
            echo "Usage: $0 {song-artist|song|artist}"
            exit 1
            ;;
    esac
fi
  
