-- ~/.config/hypr/hyprland.lua

local terminal = "kitty -c ~/.config/kitty/conf/awsm/kitty.conf"
local menu = "rofi -show drun -config ~/.config/rofi/conf/awsm/config.rasi"
local mainMod = "SUPER"

-- App launchers
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("rofi -modi emoji -show emoji -config ~/.config/rofi/conf/awsm/config.rasi -no-show-icons"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker+ -a -F \"SpaceMono Nerd Font\""))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("flameshot gui"))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Lock screen
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("hyprlock --config ~/.config/hypr/conf/awsm/hyprlock.conf"))

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
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" })) -- Move/resize windows with mouse drag

-- Media / volume keys (repeating + lock-screen active)
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true, lock = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true, lock = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { lock = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { lock = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, lock = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, lock = true })

-- Playerctl (lock-screen active)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { lock = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { lock = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { lock = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { lock = true })

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- mouse
-- move floating windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })  -- ALT + LMB: Floats a window by clicking


-- get next layout in the rotation
local function cycle_layout(current)
    local layouts = { "dwindle", "master", "monocle" }

    local next = nil
    for i, v in ipairs(layouts) do
        if v == current then
            next = layouts[i % #layouts + 1]
        end
    end

    return next
end

-- keep track of workspace layout
local workspace_l_lookup = {}
local std_layout = hl.get_config("general.layout")

-- get the layout of the current workspace
local function workspace_layout()
    local w = hl.get_active_window().workspace.id
    return workspace_l_lookup[w] and workspace_l_lookup[w] or std_layout
end

-- cycle to the next layout
hl.bind(mainMod .. " + Space", function()
    if not hl.get_active_window() then
        return
    end
    local w = hl.get_active_window().workspace
    local next_layout = cycle_layout(workspace_layout())

    hl.workspace_rule({ workspace = w.id, layout = next_layout })

    workspace_l_lookup[w.id] = next_layout
end)

-- set cycle action depending on layout
hl.bind(mainMod .. " + c", function()
    if not hl.get_active_window() then
        return
    end
    local current_layout = workspace_layout()
    if current_layout == "monocle" then
        hl.dispatch(hl.dsp.layout("cyclenext"))
    elseif current_layout == "master" then
        hl.dispatch(hl.dsp.layout("swapwithmaster"))
    end
end)

-- open nwg-display
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("nwg-displays", { float = true, center = true }))

-- open browser
hl.bind(mainMod .. " + o", hl.dsp.exec_cmd("MESA_LOADER_DRIVER_OVERRIDE=zink helium-browser")) -- fix problem with gallium driver
