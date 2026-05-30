#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/wallcycle-current"
ROFI_THEME='
* {
  bg: #1e1e2ee6;
  bg-alt: #313244cc;
  bg-card: #181825cc;
  fg: #cdd6f4;
  fg-muted: #a6adc8;
  accent: #89dceb;
}
window {
  width: 900px;
  background-color: transparent;
}
mainbox {
  padding: 16px;
  spacing: 14px;
  background-color: @bg;
  border: 1px;
  border-color: #45475a;
  border-radius: 12px;
}
inputbar {
  children: [prompt, entry];
  background-color: @bg-alt;
  padding: 8px 16px;
  border-radius: 6px;
}
prompt {
  padding: 0 6px 0 0;
  background-color: transparent;
  text-color: @accent;
}
textbox-prompt-colon {
  expand: false;
  str: "";
}
entry {
  background-color: transparent;
  text-color: @fg;
  placeholder-color: @fg-muted;
  padding: 0;
}
listview {
  columns: 4;
  lines: 1;
  flow: horizontal;
  require-input: false;
  dynamic: false;
  fixed-height: true;
  scrollbar: false;
  spacing: 10px;
  background-color: transparent;
}
element {
  orientation: vertical;
  padding: 12px;
  spacing: 8px;
  background-color: @bg-card;
  text-color: @fg-muted;
  border: 1px;
  border-color: transparent;
  border-radius: 10px;
}
element selected {
  background-color: #313244e6;
  text-color: @fg;
  border-color: @accent;
}
element-icon {
  size: 132px;
  padding: 0;
  background-color: transparent;
}
element-text {
  horizontal-align: 0.5;
  vertical-align: 0.5;
  background-color: transparent;
  text-color: inherit;
}
'

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
  done | rofi -dmenu -i -show-icons -format i -p "Select Wallpaper" -lines 1 -columns 4 -theme-str "$ROFI_THEME"
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
fi
