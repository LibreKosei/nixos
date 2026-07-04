local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('css', {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_markers = { '.git', 'package.json' },
    capabilities = capabilities,
    init_options = {
        provideFormatter = true,
    },
    settings = {
        css = {
            validate = true
        },
        less = {
            validate = true
        },
        scss = {
            validate = true
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "css",
    callback = function ()
        vim.lsp.enable("cssls")
    end
})
