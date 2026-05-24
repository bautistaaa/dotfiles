hl.config({
    general = {
        gaps_in                 = 6,
        gaps_out                = 12,
        border_size             = 1,
        ["col.active_border"]   = "rgb(f5c2e7)",
        ["col.inactive_border"] = "rgb(45475a)",
    },
})

hl.config({
    decoration = {
        rounding = 12,
        blur     = {
            enabled           = true,
            size              = 10,
            passes            = 3,
            new_optimizations = true,
            xray              = true,
        },
    },
})

hl.layer_rule({ match = { namespace = "rofi" }, no_anim = true })

hl.window_rule({ match = { class = "btop-float" }, float = true, size = {1100, 700}, center = true })

-- Window rules for floating windows
hl.window_rule({ match = { float = true }, border_size  = 1 })
hl.window_rule({ match = { float = true }, rounding     = 18 })
hl.window_rule({ match = { float = true }, border_color = "rgb(7f849c) rgb(7f849c)" })
