hl.layer_rule({
    match = { namespace = "rofi" },
    dim_around = true,
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name = "no-anim-for-selection",
    match = { namespace = "selection" },
    no_anim = true,
})

hl.window_rule({
    name = "thunar-rename-float-center",
    match = {
        class = "Thunar",
        initial_title = 'Rename ".*',
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.3", "80" },
    dim_around = true
})
