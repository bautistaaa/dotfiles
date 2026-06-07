#!/usr/bin/env bash

id="$1"
active_id="$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id // 0')"
active_id="${active_id:-0}"

hyprctl workspaces -j 2>/dev/null | jq -c --argjson id "$id" --argjson active_id "$active_id" '
	.[] | select(.id == $id) | {
		text: ($id | tostring),
		class: ([
			if $active_id == $id then "active" else empty end,
			if .windows == 0 then "empty" else empty end
		] | join(" "))
	}
'
