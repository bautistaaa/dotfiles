-- Apps
hl.bind(MAIN_MOD .. " + Return", hl.dsp.exec_cmd(TERMINAL))
hl.bind(MAIN_MOD .. " + G",      hl.dsp.exec_cmd(BROWSER))
hl.bind(MAIN_MOD .. " + E",      hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind(MAIN_MOD .. " + B",      hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-waybar.sh"))
hl.bind(MAIN_MOD .. " + X",      hl.dsp.exec_cmd("~/.config/hypr/scripts/btop-float.sh"))
hl.bind(MAIN_MOD .. " + N",      hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(MAIN_MOD .. " + W",      hl.dsp.exec_cmd("~/.config/rofi/scripts/rofi-wifi-menu.sh"))

-- General
hl.bind(MAIN_MOD .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(MAIN_MOD .. " + Z",      hl.dsp.window.pseudo())
hl.bind(MAIN_MOD .. " + P",      hl.dsp.exec_cmd("~/.config/hypr/scripts/wallcycle.sh"))
hl.bind(MAIN_MOD .. " + C",      hl.dsp.window.close())
hl.bind(MAIN_MOD .. " + M",      hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(MAIN_MOD .. " + V",      hl.dsp.window.float())
hl.bind(MAIN_MOD .. " + Space",  hl.dsp.exec_cmd(MENU))
hl.bind(MAIN_MOD .. " + grave",  hl.dsp.exec_cmd(WINDOW_MENU))
hl.bind(MAIN_MOD .. " + equal",  hl.dsp.exec_cmd(CALC_MENU))
hl.bind(MAIN_MOD .. " + F",      hl.dsp.window.fullscreen())

-- Cycle windows
hl.bind(MAIN_MOD .. " + Tab",         hl.dsp.window.cycle_next())
hl.bind(MAIN_MOD .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- Focus
hl.bind(MAIN_MOD .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(MAIN_MOD .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(MAIN_MOD .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(MAIN_MOD .. " + J", hl.dsp.focus({ direction = "d" }))

-- Swap windows
hl.bind(MAIN_MOD .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(MAIN_MOD .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(MAIN_MOD .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(MAIN_MOD .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

-- Workspaces
hl.bind(MAIN_MOD .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(MAIN_MOD .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(MAIN_MOD .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(MAIN_MOD .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(MAIN_MOD .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(MAIN_MOD .. " + 6", hl.dsp.focus({ workspace = 6 }))

hl.bind(MAIN_MOD .. " + bracketleft",  hl.dsp.focus({ workspace = "-1" }))
hl.bind(MAIN_MOD .. " + bracketright", hl.dsp.focus({ workspace = "+1" }))

-- Move window to workspace
hl.bind(MAIN_MOD .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(MAIN_MOD .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(MAIN_MOD .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(MAIN_MOD .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(MAIN_MOD .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(MAIN_MOD .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))

-- Move floating window by pixels
hl.bind(MAIN_MOD .. " + Left",  hl.dsp.window.move({ x = -80, y = 0,   relative = true }))
hl.bind(MAIN_MOD .. " + Right", hl.dsp.window.move({ x = 80,  y = 0,   relative = true }))
hl.bind(MAIN_MOD .. " + Up",    hl.dsp.window.move({ x = 0,   y = -80, relative = true }))
hl.bind(MAIN_MOD .. " + Down",  hl.dsp.window.move({ x = 0,   y = 80,  relative = true }))

-- Move / resize with mouse
hl.bind(MAIN_MOD .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MAIN_MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize active tiled window
hl.bind(MAIN_MOD .. " + CTRL + H", hl.dsp.window.resize({ x = -80, y = 0,   relative = true }))
hl.bind(MAIN_MOD .. " + CTRL + L", hl.dsp.window.resize({ x = 80,  y = 0,   relative = true }))
hl.bind(MAIN_MOD .. " + CTRL + K", hl.dsp.window.resize({ x = 0,   y = -80, relative = true }))
hl.bind(MAIN_MOD .. " + CTRL + J", hl.dsp.window.resize({ x = 0,   y = 80,  relative = true }))

-- Screenshots
hl.bind("Print",           hl.dsp.exec_cmd([[grim ~/Pictures/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind("SHIFT + Print",   hl.dsp.exec_cmd([[grim -g "$(slurp)" ~/Pictures/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind(MAIN_MOD .. " + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind(MAIN_MOD .. " + SHIFT + S", hl.dsp.exec_cmd([[grim ~/Pictures/screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png]]))
hl.bind(MAIN_MOD .. " + Print",         hl.dsp.exec_cmd("~/.config/hypr/scripts/screenrecord.sh"))
hl.bind(MAIN_MOD .. " + SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenrecord.sh area"))
hl.bind(MAIN_MOD .. " + R",             hl.dsp.exec_cmd("~/.config/hypr/scripts/screenrecord.sh"))
hl.bind(MAIN_MOD .. " + SHIFT + R",     hl.dsp.exec_cmd("~/.config/hypr/scripts/screenrecord.sh area"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true, locked = true })
