#!/usr/bin/env bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
BASE_CONFIG="$CONFIG_DIR/config"
RUNTIME_CONFIG="$CONFIG_DIR/config.runtime"

width=$(hyprctl monitors -j 2>/dev/null | jq -r 'map(select(.focused))[0] // .[0] // {width: 1440} | .width // 1440')

if ! [[ "$width" =~ ^[0-9]+$ ]] || [ "$width" -eq 0 ]; then
	width=1440
fi

margin=$(( width * 125 / 1000 ))

jq --argjson margin "$margin" '
	."margin-top" = 8
	| ."margin-left" = $margin
	| ."margin-right" = $margin
	| reduce range(1; 13) as $id (.;
		.["custom/ws-\($id)"] = {
			"format": "{}",
			"return-type": "json",
			"interval": 1,
			"hide-empty-text": true,
			"exec": "~/.config/waybar/scripts/workspace-button.sh \($id)",
			"on-click": "~/.config/waybar/scripts/workspace-click.sh \($id)"
		}
	)
	| ."group/workspaces" = {
		"orientation": "horizontal",
		"modules": [range(1; 13) | "custom/ws-\(.)"]
	}
' "$BASE_CONFIG" >"$RUNTIME_CONFIG"

exec waybar -c "$RUNTIME_CONFIG" "$@"
