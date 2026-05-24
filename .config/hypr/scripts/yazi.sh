#!/usr/bin/env bash

dir="${1:-$HOME}"
"$(dirname "$0")/launch-on-new-workspace.sh" kitty --class yazi --directory "$dir" yazi
