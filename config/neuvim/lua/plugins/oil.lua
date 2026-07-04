require("lz.n").load {
    {
        "oil.nvim",
        keys = {
            { "<C-n>", "<CMD>Oil --float<CR>", desc = "Oil" },
        },
        after = function ()
            require("oil").setup({
                keymaps = {
                    ["<C-n>"] = { "actions.close" },
                    ["Esc"] = { "actions.close" },
                    ["q"] = {"actions.close"},
                    ["<S-h>"] = { "actions.parent" },
                }
            })
        end,
    }
}
