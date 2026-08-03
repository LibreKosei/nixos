local colors = require("lua.colors")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border = colors.everblush.blue,
            inactive_border = colors.everblush.lighter_background,
        },

        resize_on_border = true,

        allow_tearing = false,

        layout = "scrolling",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})
