#!/usr/bin/env bash

CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
MODE_FILE="$CACHE_HOME/dotfiles/theme/mode"
LOG_FILE="$CACHE_HOME/dotfiles/theme/wallpaper.log"

read_mode() {
  local mode

  for mode in light dark; do
    if [[ "$(readlink -f "$CONFIG_HOME/rofi/themes/current.rasi" 2>/dev/null || true)" == "$(readlink -f "$CONFIG_HOME/rofi/themes/$mode.rasi" 2>/dev/null || true)" ]]; then
      printf '%s\n' "$mode"
      return
    fi
  done

  mode="$(<"$MODE_FILE" 2>/dev/null || printf 'dark')"

  case "$mode" in
    dark|light) printf '%s\n' "$mode" ;;
    *) printf 'dark\n' ;;
  esac
}

MODE="$(read_mode)"
WALL_DIR="$HOME/Pictures/wallpapers/$MODE"
WALL_DIR_REAL="$(readlink -f "$WALL_DIR" 2>/dev/null || true)"
STATE_FILE="$CACHE_HOME/hypr/wallcycle-current"
CURRENT_WALLPAPER="$CACHE_HOME/dotfiles/theme/current-wallpaper"
ROFI_THEME="$HOME/.config/rofi/wallpaper.rasi"

pgrep -x swww-daemon >/dev/null || swww-daemon &
sleep 0.5

mapfile -t WALLS < <(
  find -L "$WALL_DIR" -mindepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    2>/dev/null |
    while IFS= read -r wall; do
      wall_real="$(readlink -f "$wall" 2>/dev/null || true)"
      [[ -n "$WALL_DIR_REAL" && "$wall_real" == "$WALL_DIR_REAL"/* ]] && printf '%s\n' "$wall"
    done |
    sort
)

if ((${#WALLS[@]} == 0)); then
  mkdir -p "$(dirname "$LOG_FILE")"
  printf '%s wallselect mode=%s dir=%s count=0\n' "$(date '+%F %T')" "$MODE" "$WALL_DIR_REAL" >>"$LOG_FILE"
  notify-send "wallselect" "No wallpapers found in $WALL_DIR" 2>/dev/null || true
  exit 1
fi

mkdir -p "$(dirname "$LOG_FILE")"
printf '%s wallselect mode=%s dir=%s count=%s\n' "$(date '+%F %T')" "$MODE" "$WALL_DIR_REAL" "${#WALLS[@]}" >>"$LOG_FILE"

SELECTED_INDEX=$(
  for WALL in "${WALLS[@]}"; do
    printf '%s/%s\0icon\x1f%s\n' "$MODE" "${WALL#$WALL_DIR/}" "$WALL"
  done | rofi -dmenu -i -show-icons -no-custom -disable-history -format i -p "Select $MODE Wallpaper" -lines 1 -columns 4 -theme "$ROFI_THEME"
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
  mkdir -p "$(dirname "$CURRENT_WALLPAPER")"
  rm -f "$CURRENT_WALLPAPER"
  ln -s "$WALL" "$CURRENT_WALLPAPER"
  notify-send "Wallpaper changed" "$(basename "$WALL")" --icon "$WALL" 2>/dev/null || true
fi
