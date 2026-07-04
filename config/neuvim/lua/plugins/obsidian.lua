require('lz.n').load {
    "obsidian.nvim",
    ft = "markdown",
    after = function ()
        require("obsidian").setup {
            workspaces = {
                {
                    name = "school",
                    path = "~/vault/School",
                },
                {
                    name = "personal",
                    path = "~/vault/Personal"
                },
            },
        }
    end
}
