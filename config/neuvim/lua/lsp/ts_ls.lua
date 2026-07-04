vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    callback = function ()
        vim.lsp.enable('ts_ls')
    end
})
