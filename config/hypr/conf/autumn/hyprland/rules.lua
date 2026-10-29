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
