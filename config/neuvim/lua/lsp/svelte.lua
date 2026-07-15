vim.lsp.config('svelteserver', {
    cmd = { 'svelteserver', '--stdio' },
    filetypes = { 'svelte' },
    root_markers = {'package.json', '.git'},
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "svelte",
    callback = function ()
        vim.lsp.enable("svelteserver")
        vim.treesitter.start()
    end
})
