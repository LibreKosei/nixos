vim.lsp.config('qmlls', {
    cmd = { 'qmlls' },
    filetypes = { 'qml', 'qmljs' },
    root_markers = { '.git' },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qml',
    callback = function ()
        vim.lsp.enable('qmlls')
        vim.treesitter.start()
    end
})
