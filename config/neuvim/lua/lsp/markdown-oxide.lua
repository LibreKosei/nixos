local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.lsp.config('markdown-oxide', {
    cmd = { 'markdown-oxide' },
    filetypes = { 'markdown' },
    root_markers = { '.git', '.obsidian', '.monoxide.toml' },
    capabilities = capabilities,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function ()
        vim.lsp.enable("markdown-oxide")
    end
})
