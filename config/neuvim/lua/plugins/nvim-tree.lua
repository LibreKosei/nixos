require("lz.n").load {
    {
        "nvim-tree.lua",
        keys = {
            { "<C-n>", "<CMD>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
            { "<leader>e", "<CMD>NvimTreeFocus<CR>", desc = "Focus back to nvim tree"},
        },
        after = function ()
            require("nvim-tree").setup({

                view = {
                    adaptive_size = true,
                },
            })
        end
    }
}
