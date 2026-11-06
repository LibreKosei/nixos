return {
    {
        "conform-nvim",
        event = "BufWritePre",
        cmd = "ComformInfo",
        after = function() 
            require("conform").setup(require "configs.conform")
        end,
    }
}
