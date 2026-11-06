return {
    {
        "which-key.nvim",
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        after = function() 
            dofile(vim.g.base46_cache .. "whichkey")
            require("which-key").setup(require "nvchad.configs.whichkey")
        end,
    }
}
