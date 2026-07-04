require("lz.n").load {
    {
        "nvim-colorizer.lua",
        event = "DeferredUIEnter",
        after = function ()
            require("colorizer").setup({
                filetypes = {
                    "!TelescopePrompt",
                    "!TelescopeResults",
                    "!NvimTree",
                },
                mode = 'virtualtext',
              })
        end,
    }
}

