require('lz.n').load({
    "markview.nvim",
    lazy = false,
    -- after = function()
    --     require("markview").setup({
    --
    --     })
    -- end,
})

vim.keymap.set('n', '<A-m>', "<CMD>Markview splitToggle<CR>", {
    desc = "Toggle markview split",
})
