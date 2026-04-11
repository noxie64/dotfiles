#!/bin/sh

if pgrep -x kitty >/dev/null; then
    echo "test"
    curr=$(kitty @ ls 2>/dev/null | jq -r '.[] | select(.is_focused==true) | .tabs[].windows[].cwd' | head -n1)

    if [ -n "$curr" ]; then
        kitty --directory "$curr"
    else
        kitty
    fi
else
    kitty
fi
