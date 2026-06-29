--@alias Dispatcher function(): nil
--@class BindEntry
--@field key        string 
--@field dispatcher Dispatcher 
--@field opts?      table

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "qs ipc call launcher-panel toggle"
local browser = "uwsm app -- firefox"

--@type BindEntry[]
local binds = {
    {
        key = mainMod .. " + SHIFT + Return",
        dispatcher = hl.dsp.exec_cmd(terminal),
        opts = { description = "Spawn Kitty terminal" },
    },
    {
        key = mainMod .. " + SHIFT + Q",
        dispatcher = hl.dsp.exec_cmd(
          "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
        ),
        opts = { description = "Kill Hyprland" },
    },
    {
        key = mainMod .. " + SHIFT + C",
        dispatcher = hl.dsp.window.close(),
        opts = { description = "Close focused window" },
    },
    {
        key = "Print",
        dispatcher = hl.dsp.exec_cmd("hyprshot -m region"),
        opts = { description = "Take screenshot (select region)" },
    },
    {
        key = mainMod .. " + B",
        dispatcher = hl.dsp.exec_cmd(browser),
        opts = { description = "Launch browser" },
    },

}

--@type BindEntry[]
local layout_binds = {
    {
        key = mainMod .. " + period",
        dispatcher = hl.dsp.layout("colresize +conf"),
        opts = { description = "Cycle through predefined width", },
    },
    {
        key = mainMod .. " + comma",
        dispatcher = hl.dsp.layout("colresize -conf"),
        opts = { description = "Cycle through predefined width (backward)", },
    },
}

--@type BindEntry[]
local scroll_binds = {
    {
        key = mainMod .. " + H",
        dispatcher = hl.dsp.layout("focus left"),
        opts = { description = "Focus left window in scrolling mode", },
    },
    {
        key = mainMod .. " + L",
        dispatcher = hl.dsp.layout("focus right"),
        opts = { description = "Focus right window in scrolling mode", },
    },
    {
        key = mainMod .. " + SHIFT + H",
        dispatcher = hl.dsp.layout("swapcol l"),
        opts = { description = "Swap the current window with left one", },
    },
    {
        key = mainMod .. " + SHIFT + L",
        dispatcher = hl.dsp.layout("swapcol r"),
        opts = { description = "Swap the current window with left one", },
    }
}

for _, value in ipairs(binds) do
    hl.bind(value.key, value.dispatcher, value.opts)
end

for _, value in ipairs(layout_binds) do
    hl.bind(value.key, value.dispatcher, value.opts)
end

for _, value in ipairs(scroll_binds) do
    hl.bind(value.key, value.dispatcher, value.opts)
end

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
