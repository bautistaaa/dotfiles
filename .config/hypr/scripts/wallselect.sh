#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/wallcycle-current"
ROFI_THEME="$HOME/.config/rofi/wallpaper.rasi"

pgrep -x swww-daemon >/dev/null || swww-daemon &
sleep 0.5

mapfile -t WALLS < <(
  find -L "$WALL_DIR" -mindepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | sort
)

if ((${#WALLS[@]} == 0)); then
  notify-send "wallselect" "No wallpapers found in $WALL_DIR" 2>/dev/null || true
  exit 1
fi

SELECTED_INDEX=$(
  for WALL in "${WALLS[@]}"; do
    printf '%s\0icon\x1f%s\n' "${WALL#$WALL_DIR/}" "$WALL"
  done | rofi -dmenu -i -show-icons -format i -p "Select Wallpaper" -lines 1 -columns 4 -theme "$ROFI_THEME"
) || exit 0

[[ -z "$SELECTED_INDEX" ]] && exit 0
[[ "$SELECTED_INDEX" =~ ^[0-9]+$ ]] || exit 0
WALL="${WALLS[$SELECTED_INDEX]}"
[[ -n "$WALL" ]] || exit 0

if swww img "$WALL" \
  --transition-type grow \
  --transition-duration 1; then
  mkdir -p "$(dirname "$STATE_FILE")"
  printf '%s\n' "$WALL" >"$STATE_FILE"
  notify-send "Wallpaper changed" "$(basename "$WALL")" --icon "$WALL" 2>/dev/null || true
fi
