#!/usr/bin/env bash

id="$1"

python3 - "$id" <<'PY'
import json
import subprocess
import sys

workspace_id = int(sys.argv[1])
workspaces = json.loads(subprocess.check_output(["hyprctl", "workspaces", "-j"]))
active = json.loads(subprocess.check_output(["hyprctl", "activeworkspace", "-j"]))
match = next((ws for ws in workspaces if ws["id"] == workspace_id), None)

if match is None:
    raise SystemExit(0)

classes = []
if active["id"] == workspace_id:
    classes.append("active")
if match["windows"] == 0:
    classes.append("empty")

print(json.dumps({"text": str(workspace_id), "class": " ".join(classes)}))
PY
