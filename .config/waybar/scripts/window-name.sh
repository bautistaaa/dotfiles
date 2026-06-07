#!/usr/bin/env bash

class=$(hyprctl activewindow -j 2>/dev/null | jq -r '.class // empty')

case "$class" in
	kitty) echo Kitty ;;
	google-chrome) echo Chrome ;;
	*) hyprctl activewindow -j 2>/dev/null | jq -r '.title // empty |@html' ;;
esac
