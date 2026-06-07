#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
THEME_CACHE="$CACHE_HOME/dotfiles/theme"
MODE_FILE="$THEME_CACHE/mode"
WALL_STATE_FILE="$CACHE_HOME/hypr/wallcycle-current"
CURRENT_WALLPAPER="$THEME_CACHE/current-wallpaper"

case "$MODE" in
  dark|light) ;;
  *)
    printf 'Usage: %s dark|light\n' "$0" >&2
    exit 2
    ;;
esac

mkdir -p "$THEME_CACHE" "$(dirname "$WALL_STATE_FILE")"
printf '%s\n' "$MODE" >"$MODE_FILE"

link_theme() {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" ]]; then
    notify-send "Theme switch" "Missing theme file: $src" 2>/dev/null || true
    return 1
  fi

  mkdir -p "$(dirname "$dest")"
  rm -f "$dest"
  ln -s "$src" "$dest"
}

apply_theme_links() {
  local btop_theme

  if [[ "$MODE" == "dark" ]]; then
    btop_theme="catppuccin_mocha"
  else
    btop_theme="gruvbox_light_hard"
  fi

  link_theme "$CONFIG_HOME/rofi/themes/$MODE.rasi" "$CONFIG_HOME/rofi/themes/current.rasi"
  link_theme "$CONFIG_HOME/rofi/themes/$MODE-wallpaper.rasi" "$CONFIG_HOME/rofi/themes/current-wallpaper.rasi"
  link_theme "$CONFIG_HOME/kitty/themes/$MODE.conf" "$CONFIG_HOME/kitty/themes/current.conf"
  link_theme "$CONFIG_HOME/waybar/themes/$MODE.css" "$CONFIG_HOME/waybar/themes/current.css"
  link_theme "$CONFIG_HOME/swaync/themes/$MODE.css" "$CONFIG_HOME/swaync/themes/current.css"
  link_theme "$CONFIG_HOME/hypr/themes/$MODE-appearance.lua" "$CONFIG_HOME/hypr/themes/current-appearance.lua"
  link_theme "$CONFIG_HOME/hypr/themes/$MODE-hyprlock.conf" "$CONFIG_HOME/hypr/themes/current-hyprlock.conf"
  link_theme "$CONFIG_HOME/btop/themes/$btop_theme.theme" "$CONFIG_HOME/btop/themes/current.theme"
}

select_wallpaper() {
  local wall_dir="$HOME/Pictures/wallpapers/$MODE"
  local wall_dir_real

  wall_dir_real="$(readlink -f "$wall_dir" 2>/dev/null || true)"

  mapfile -t walls < <(
    find -L "$wall_dir" -mindepth 1 -type f \
      \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
      2>/dev/null |
      while IFS= read -r wall; do
        wall_real="$(readlink -f "$wall" 2>/dev/null || true)"
        [[ -n "$wall_dir_real" && "$wall_real" == "$wall_dir_real"/* ]] && printf '%s\n' "$wall"
      done |
      sort
  )

  if ((${#walls[@]} == 0)); then
    notify-send "Theme switch" "No wallpapers found in $wall_dir" 2>/dev/null || true
    return 0
  fi

  local wall default_wall

  case "$MODE" in
    dark) default_wall="$wall_dir/makeup.jpg" ;;
    light) default_wall="$wall_dir/the-wind-rises-background-art-garden.png" ;;
    *) default_wall="" ;;
  esac

  if [[ -n "$default_wall" && -f "$default_wall" ]]; then
    wall="$default_wall"
  else
    wall=$(printf '%s\n' "${walls[@]}" | shuf -n 1)
  fi

  rm -f "$CURRENT_WALLPAPER"
  ln -s "$wall" "$CURRENT_WALLPAPER"
  printf '%s\n' "$wall" >"$WALL_STATE_FILE"

  if ! pgrep -x swww-daemon >/dev/null; then
    swww-daemon >/dev/null 2>&1 &
  fi
  sleep 0.5
  swww img "$wall" --transition-type grow --transition-duration 1 >/dev/null 2>&1 || true
}

reload_services() {
  local active_border inactive_border kitty_opacity kitty_remote

  if [[ "$MODE" == "dark" ]]; then
    active_border="rgb(f5c2e7)"
    inactive_border="rgb(45475a)"
    kitty_opacity="0.25"
  else
    active_border="rgb(b57614)"
    inactive_border="rgb(d5c4a1)"
    kitty_opacity="0.92"
  fi

  kitty_remote="unix:@dotfiles-kitty"
  kitty @ --to "$kitty_remote" load-config "$CONFIG_HOME/kitty/kitty.conf" >/dev/null 2>&1 || true
  kitty @ --to "$kitty_remote" set-colors -a -c "$CONFIG_HOME/kitty/themes/$MODE.conf" >/dev/null 2>&1 || true
  kitty @ --to "$kitty_remote" set-background-opacity -a "$kitty_opacity" >/dev/null 2>&1 || true
  timeout 2s hyprctl keyword general:col.active_border "$active_border" >/dev/null 2>&1 || true
  timeout 2s hyprctl keyword general:col.inactive_border "$inactive_border" >/dev/null 2>&1 || true

  if pgrep -x waybar >/dev/null; then
    pkill -SIGUSR2 -x waybar >/dev/null 2>&1 || {
      pkill -x waybar >/dev/null 2>&1 || true
      "$CONFIG_HOME/waybar/launch.sh" >/dev/null 2>&1 &
    }
  fi

  if pgrep -x swaync >/dev/null; then
    timeout 2s swaync-client -rs >/dev/null 2>&1 || {
      pkill -x swaync >/dev/null 2>&1 || true
      swaync >/dev/null 2>&1 &
    }
  fi
}

apply_system_color_scheme() {
  local color_scheme

  if [[ "$MODE" == "dark" ]]; then
    color_scheme="prefer-dark"
  else
    color_scheme="prefer-light"
  fi

  gsettings set org.gnome.desktop.interface color-scheme "$color_scheme" >/dev/null 2>&1 || true
}

apply_theme_links
apply_system_color_scheme
select_wallpaper
reload_services

notify-send "Theme switched" "$MODE" 2>/dev/null || true
