local function match_colors(prefix)
    return vim.tbl_filter(function (name) 
        return name:match("^" .. prefix)
    end, vim.fn.getcompletion("", "color"))
end

require("lz.n").load {
    {
        "kanagawa.nvim",
        colorscheme = { "kanagawa", "kanagawa-dragon", "kanagawa-lotus", "kanagawa-wave" }
    },
    {
        "vimplugin-everblush.nvim",
        colorscheme = "everblush"
    },
    {
        "tokyonight.nvim",
        colorscheme = { "tokyonight", "tokyonight-storm", "tokyonight-day", "tokyonight-night", "tokyonight-moon" }
    },
    {
        "material.nvim",
        colorscheme = {
            "material",
            "material-darker",
            "material-deep-ocean",
            "material-lighter",
            "material-palenight",
            "material-oceanic"
        },
    },
    {
        "nightfox.nvim",
        colorscheme = {
            "nightfox",
            "dayfox",
            "dawnfox",
            "duskfox",
            "nordfox",
            "terafox",
            "carbonfox"
        },
    },
    {
        "catppuccin-nvim",
        colorscheme = {
            "catppuccin",
            "catppuccin-frappe",
            "catppuccin-latte",
            "catppuccin-macchiato",
            "catppuccin-mocha",
        },
    },
    {
        "onedarkpro.nvim",
        colorscheme = {
            "onedark",
            "onedark_dark",
            "onedark_vivid",
        },
    },
    {
        "gruvbox.nvim",
        colorscheme = {
            "gruvbox"
        },
    },
    {
        "everforest",
        colorscheme = {
              "everforest"
        },
    },
    {
        "bamboo.nvim",
        colorscheme = {
            "bamboo",
            "bamboo-light",
            "bamboo-vulgaris",
            "bamboo-multiplex",
        },
    },
    {
        "vimplugin-pastel.nvim",
        colorscheme = match_colors("pastel"),
    },
    {
        "vimplugin-one_monokai.nvim",
        colorscheme = {
            "one_monokai",
        },
    }
}
