#!/usr/bin/env bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
BASE_CONFIG="$CONFIG_DIR/config"
RUNTIME_CONFIG="$CONFIG_DIR/config.runtime"

width=$(hyprctl monitors -j 2>/dev/null | python3 -c "
import json, sys
try:
    monitors = json.load(sys.stdin)
except Exception:
    monitors = []
focused = next((m for m in monitors if m.get('focused')), monitors[0] if monitors else None)
print(focused['width'] if focused else 1440)
")

if ! [[ "$width" =~ ^[0-9]+$ ]] || [ "$width" -eq 0 ]; then
	width=1440
fi

margin=$(( width * 125 / 1000 ))

python3 - "$BASE_CONFIG" "$RUNTIME_CONFIG" "$margin" <<'PY'
import json
import subprocess
import sys

base_path, runtime_path, margin = sys.argv[1:4]
margin = int(margin)

with open(base_path, encoding="utf-8") as f:
    config = json.load(f)

config["margin-top"] = 8
config["margin-left"] = margin
config["margin-right"] = margin

try:
    subprocess.check_output(["hyprctl", "workspaces", "-j"])
except Exception:
    pass

max_id = 12

module_names = []
for workspace_id in range(1, max_id + 1):
    name = f"custom/ws-{workspace_id}"
    module_names.append(name)
    config[name] = {
        "format": "{}",
        "return-type": "json",
        "interval": 1,
        "hide-empty-text": True,
        "exec": f"~/.config/waybar/scripts/workspace-button.sh {workspace_id}",
        "on-click": f"~/.config/waybar/scripts/workspace-click.sh {workspace_id}",
    }

config["group/workspaces"] = {
    "orientation": "horizontal",
    "modules": module_names,
}

with open(runtime_path, "w", encoding="utf-8") as f:
    json.dump(config, f, indent="\t")
    f.write("\n")
PY

exec waybar -c "$RUNTIME_CONFIG" "$@"
