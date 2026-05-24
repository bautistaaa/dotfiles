#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.focus({ workspace = "emptyn" })'
target="$(hyprctl activeworkspace -j | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")"

"$@" &
pid=$!

for _ in $(seq 1 60); do
  result="$(hyprctl clients -j | python3 -c "
import sys, json
for c in json.load(sys.stdin):
    if c['pid'] == $pid:
        print(c['address'], c['workspace']['id'])
        break
")"

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
