#!/bin/bash

set -euo pipefail

notify() {
  notify-send "screenrecord" "$1" 2>/dev/null || true
}

if pgrep -x wf-recorder >/dev/null; then
  pkill -INT wf-recorder
  notify "Recording saved"
  exit 0
fi

if ! command -v wf-recorder >/dev/null 2>&1; then
  notify "wf-recorder is not installed. Install it with: sudo apt install wf-recorder"
  exit 1
fi

mkdir -p "$HOME/Videos/recordings"
OUT="$HOME/Videos/recordings/$(date +'%Y-%m-%d_%H-%M-%S').mp4"

if [[ "${1:-}" == "area" ]]; then
  GEOMETRY=$(slurp)
  wf-recorder -g "$GEOMETRY" -f "$OUT" >/tmp/wf-recorder.log 2>&1 &
else
  wf-recorder -f "$OUT" >/tmp/wf-recorder.log 2>&1 &
fi

notify "Recording started: $OUT"
