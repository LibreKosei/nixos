return {
    {
        "gitsigns.nvim",
        event = "User FilePost",
        after = function() 
            dofile(vim.g.base46_cache .. "git")
            require("gitsigns").setup(require "nvchad.configs.gitsigns")
        end,
    }
}
