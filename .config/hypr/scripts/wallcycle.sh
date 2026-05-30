#!/bin/bash

pgrep -x swww-daemon >/dev/null || swww-daemon &
sleep 0.5

WALL_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/wallcycle-current"

mapfile -t WALLS < <(find -L "$WALL_DIR" -mindepth 1 -type f)
CURRENT=$(swww query 2>/dev/null | sed -n 's/.*image: //p' | head -n 1)
[[ -n "$CURRENT" ]] || CURRENT=$(<"$STATE_FILE" 2>/dev/null || true)

if ((${#WALLS[@]} > 1)) && [[ -n "$CURRENT" ]]; then
  CURRENT_REAL=$(readlink -f "$CURRENT" 2>/dev/null || printf '%s\n' "$CURRENT")
  CANDIDATES=()

  for WALL in "${WALLS[@]}"; do
    WALL_REAL=$(readlink -f "$WALL" 2>/dev/null || printf '%s\n' "$WALL")
    [[ "$WALL_REAL" == "$CURRENT_REAL" ]] || CANDIDATES+=("$WALL")
  done

  ((${#CANDIDATES[@]} > 0)) || CANDIDATES=("${WALLS[@]}")
else
  CANDIDATES=("${WALLS[@]}")
fi

WALL=$(printf "%s\n" "${CANDIDATES[@]}" | shuf -n 1)
TRANSITION=$(printf "%s\n" fade left right top bottom wipe wave grow center any outer | shuf -n 1)

if [[ -z "$WALL" ]]; then
  notify-send "wallcycle" "No wallpapers found in $WALL_DIR" 2>/dev/null || true
  exit 1
fi

if swww img "$WALL" \
  --transition-type "$TRANSITION" \
  --transition-duration 1; then
  mkdir -p "$(dirname "$STATE_FILE")"
  printf '%s\n' "$WALL" >"$STATE_FILE"
  notify-send "Wallpaper changed" "$(basename "$WALL")" --icon "$WALL" 2>/dev/null || true
fi
