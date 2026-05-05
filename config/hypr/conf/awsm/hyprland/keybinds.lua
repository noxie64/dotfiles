-- ~/.config/hypr/hyprland.lua

local terminal = "kitty -c ~/.config/kitty/conf/awsm/kitty.conf"
local menu     = "rofi -show drun"
local mainMod  = "SUPER"

-- App launchers
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + S",      hl.dsp.exec_cmd("flameshot gui"))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Lock screen
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("hyprlock"))

-- Move focus (vim-style)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Move focused window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))-- Move/resize windows with mouse drag

-- Media / volume keys (repeating + lock-screen active)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { repeating = true, lock = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { repeating = true, lock = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { lock = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { lock = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { repeating = true, lock = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { repeating = true, lock = true })

-- Playerctl (lock-screen active)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { lock = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { lock = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { lock = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { lock = true })

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0,   relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x =  20, y = 0,   relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0,   y = -20, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0,   y =  20, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)
