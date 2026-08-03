hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "force floating mode for matplotlib window",
    match = {
        class = "Matplotlib",
    },
    float = true,
})

hl.window_rule({
    name = "force floating mode for XDG Desktop Portal",
    match = {
        class = "(xdg-desktop-portal-)(.*)*",
    },
    animation = "popin",
    max_size = { 800, 600 }
})

hl.window_rule({
    name = "force floating mode for Bitwarden",
    match = {
        title = "(?i).*bitwarden.*"
    },
    float = true,
    max_size = { 800, 600 },
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
