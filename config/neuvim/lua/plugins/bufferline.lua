require("lz.n").load {
    {
        "bufferline.nvim",
        event = "BufRead",
        after = function ()
            require("bufferline").setup({})
            vim.keymap.set("n", "<Tab>", "<CMD>BufferLineCycleNext<CR>", { silent = true })
            vim.keymap.set("n", "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", {silent = true})
            vim.keymap.set("n", "<leader>x", "<CMD>bd<CR>", { silent = true })
            for i = 1, 9 do
                vim.keymap.set("n", "<M-" .. i .. ">",
                    "<CMD>BufferLineGoToBuffer " .. i .. "<CR>",
                    { silent = true }
                )
            end
        end
    }
}
