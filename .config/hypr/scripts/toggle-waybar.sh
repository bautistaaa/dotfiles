#!/bin/bash

if pgrep -x waybar > /dev/null; then
    killall waybar
else
    ~/.config/waybar/launch.sh &
fi
