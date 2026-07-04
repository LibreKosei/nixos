require('lz.n').load({
    "markview.nvim",
    lazy = false,
})

vim.keymap.set('n', '<A-m>', "<CMD>Markview splitToggle<CR>", {
    desc = "Toggle markview split",
})
