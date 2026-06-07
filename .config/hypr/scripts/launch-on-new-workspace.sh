#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.focus({ workspace = "emptyn" })'
target="$(hyprctl activeworkspace -j | jq -r '.id')"

"$@" &
pid=$!

for _ in $(seq 1 60); do
  result="$(hyprctl clients -j | jq -r --argjson pid "$pid" '.[] | select(.pid == $pid) | [.address, .workspace.id] | @tsv')"

  if [[ -n "$result" ]]; then
    read -r addr ws <<< "$result"
    if [[ "$ws" != "$target" ]]; then
      hyprctl dispatch "hl.dsp.window.move({ window = \"address:$addr\", workspace = $target })"
    fi
    hyprctl dispatch "hl.dsp.focus({ workspace = $target })"
    exit 0
  fi

  sleep 0.05
done

exit 1
