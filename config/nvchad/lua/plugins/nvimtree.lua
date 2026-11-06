return {
    {
        "nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        after = function() 
            dofile(vim.g.base46_cache .. "nvimtree")
            local opts = require("nvchad.configs.nvimtree")

            opts.view = {
                adaptive_size = true,
            }

            require("nvim-tree").setup(opts)
        end,
    }
}
