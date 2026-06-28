local colors = require("lua.colors")

hl.config({
    general = {
        gaps_in = 20,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border = colors.everblush.blue,
            inactive_border = colors.everblush.lighter_background,
        },

        resize_on_border = true,

        allow_tearing = false,

        layout = "scrolling",
    },
})
