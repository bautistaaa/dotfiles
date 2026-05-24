#!/usr/bin/env bash
exec rofi \
  -show calc \
  -modi calc \
  -no-show-match \
  -no-sort \
  -no-history \
  -lines 0 \
  -calc-command "wl-copy '{result}'" \
  -theme "$HOME/.config/rofi/config.rasi"
