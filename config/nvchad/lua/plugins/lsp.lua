return {
    {
        "nvim-lspconfig",
        event = "User FilePost",
        after = function() 
            require "config.lspconfig"
        end,
    }
}
