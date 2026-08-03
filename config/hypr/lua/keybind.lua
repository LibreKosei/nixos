--@alias Dispatcher function(): nil
--@class BindEntry
--@field key        string 
--@field dispatcher Dispatcher 
--@field opts?      table

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "qs -p ~/nixos/config/quickshell ipc call shell toggleLauncher"
local browser = "uwsm app -- firefox"
local obs = "uwsm app -- obs"

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
    {
        key = mainMod .. " + O",
        dispatcher = hl.dsp.exec_cmd(obs),
        opts = { description = "Launch OBS" },
    },
}

local function layout_bind(bind_table)
    return function ()
        local workspace = hl.get_active_special_workspace() or
                          hl.get_active_workspace()

        if not workspace then
            return
        end

        local layout = workspace.tiled_layout
                
        if bind_table[layout] then
            hl.dispatch(bind_table[layout])
        end
    end
end

--@type BindEntry[]
local layout_binds = {
    {
        key = mainMod .. " + period",
        dispatcher = layout_bind({
            scrolling = (hl.dsp.layout("colresize +conf"))
        }),
        opts = { description = "Cycle through predefined width", },
    },
    {
        key = mainMod .. " + comma",
        dispatcher = layout_bind({
            scrolling = hl.dispatch(hl.dsp.layout("colresize -conf"))
        }),
        opts = { description = "Cycle through predefined width (backward)", },
    },
    {
        key = mainMod .. " + tab",
        dispatcher = function () 
                local layouts     = { "scrolling", "master", "monocle" }
                local workspace   = hl.get_active_workspace()
                if hl.get_active_special_workspace() then
                  workspace = hl.get_active_special_workspace()
                end

                local next_layout = "master"

                if not workspace then
                    return
                end

                for i = 1, #layouts do
                    if layouts[i] == workspace.tiled_layout then
                        local next_layout_idx = (i % #layouts) + 1
                        next_layout = layouts[next_layout_idx]
                        break
                    end
                end

                if workspace.special then
                  hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
                else
                  hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
                end
        end,
    }
}

--@type BindEntry[]
local general_binds = {
    {
        key = mainMod .. " + H",
        dispatcher = hl.dsp.focus({ direction = "left" }),
        opts = { description = "Focus left window in scrolling mode", },
    },
    {
        key = mainMod .. " + L",
        dispatcher = hl.dsp.focus({ direction = "right" }),
        opts = { description = "Focus right window in scrolling mode", },
    },
    {
        key = mainMod .. " + J",
        dispatcher = hl.dsp.focus({ direction = "down" }),
        opts = { description = "Focus right window in scrolling mode", },
    },
    {
        key = mainMod .. " + K",
        dispatcher = hl.dsp.focus({ direction = "up" }),
        opts = { description = "Focus right window in scrolling mode", },
    },
    {
        key = mainMod .. " + SHIFT + H",
        dispatcher = layout_bind({
            scrolling = hl.dsp.layout("swapcol l"),
            master = hl.dsp.layout("swapnext"),
        }),
        opts = { description = "Swap the current window with left one", },
    },
    {
        key = mainMod .. " + SHIFT + L",
        dispatcher = layout_bind({
            scrolling = hl.dsp.layout("swapcol r"),
            master = hl.dsp.layout("swapprev")
        }),
        opts = { description = "Swap the current window with left one", },
    }
}

for _, value in ipairs(binds) do
    hl.bind(value.key, value.dispatcher, value.opts)
end

for _, value in ipairs(layout_binds) do
    hl.bind(value.key, value.dispatcher, value.opts)
end

for _, value in ipairs(general_binds) do
    hl.bind(value.key, value.dispatcher, value.opts)
end

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

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
