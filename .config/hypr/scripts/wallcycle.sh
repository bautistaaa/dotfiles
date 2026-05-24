#!/bin/bash

pgrep -x swww-daemon >/dev/null || swww-daemon &
sleep 0.5

WALL=$(find -L "$HOME/Pictures/wallpapers" -mindepth 1 -type f | shuf -n 1)
TRANSITION=$(printf "%s\n" fade left right top bottom wipe wave grow center any outer | shuf -n 1)

if [[ -z "$WALL" ]]; then
  notify-send "wallcycle" "No wallpapers found in ~/Pictures/wallpapers" 2>/dev/null || true
  exit 1
fi

swww img "$WALL" \
  --transition-type "$TRANSITION" \
  --transition-duration 1
