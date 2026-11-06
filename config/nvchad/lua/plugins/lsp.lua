return {
    {
        "nvim-lspconfig",
        event = "User FilePost",
        after = function() 
            require "configs.lspconfig"
        end,
    }
}
