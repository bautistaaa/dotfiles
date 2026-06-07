#!/usr/bin/env bash
set -euo pipefail

CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
MODE_FILE="$CACHE_HOME/dotfiles/theme/mode"
CURRENT="$(<"$MODE_FILE" 2>/dev/null || printf 'dark')"

CHOICE=$(
  printf 'Dark\nLight\n' |
    env ROFI_WINDOW=true rofi -dmenu -i -p "Theme ($CURRENT)" -lines 2 -theme "$HOME/.config/rofi/config.rasi"
) || exit 0

case "${CHOICE,,}" in
  dark) exec "$HOME/.config/hypr/scripts/theme-switch.sh" dark ;;
  light) exec "$HOME/.config/hypr/scripts/theme-switch.sh" light ;;
  *) exit 0 ;;
esac
