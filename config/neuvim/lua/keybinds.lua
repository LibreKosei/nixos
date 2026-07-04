vim.keymap.set('n', '<leader>h', '<CMD>noh<CR>', {
    noremap = true,
    silent = true,
    desc = "Clear search"
})

vim.keymap.set('n', ';', ':', {
    desc = "CMD enter command mode",
})
