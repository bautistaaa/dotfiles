#!/bin/bash

pgrep -x swww-daemon >/dev/null || swww-daemon &
sleep 0.5

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

mapfile -t WALLS < <(
  find -L "$WALL_DIR" -mindepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    2>/dev/null |
    while IFS= read -r wall; do
      wall_real="$(readlink -f "$wall" 2>/dev/null || true)"
      [[ -n "$WALL_DIR_REAL" && "$wall_real" == "$WALL_DIR_REAL"/* ]] && printf '%s\n' "$wall"
    done
)
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

mkdir -p "$(dirname "$LOG_FILE")"
printf '%s wallcycle mode=%s dir=%s count=%s selected=%s\n' "$(date '+%F %T')" "$MODE" "$WALL_DIR_REAL" "${#WALLS[@]}" "$WALL" >>"$LOG_FILE"

if [[ -z "$WALL" ]]; then
  notify-send "wallcycle" "No wallpapers found in $WALL_DIR" 2>/dev/null || true
  exit 1
fi

if swww img "$WALL" \
  --transition-type "$TRANSITION" \
  --transition-duration 1; then
  mkdir -p "$(dirname "$STATE_FILE")"
  printf '%s\n' "$WALL" >"$STATE_FILE"
  mkdir -p "$(dirname "$CURRENT_WALLPAPER")"
  rm -f "$CURRENT_WALLPAPER"
  ln -s "$WALL" "$CURRENT_WALLPAPER"
  notify-send "Wallpaper changed" "$(basename "$WALL")" --icon "$WALL" 2>/dev/null || true
fi
