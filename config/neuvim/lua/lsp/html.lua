--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('html', {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html' },
    root_markers = { '.git', 'package.json' },
    init_options = {
        configurationSection = { 'html', 'css', 'javascript' },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
    capabilities = capabilities,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "html",
    callback = function ()
        vim.lsp.enable("html")
    end
})

vim.lsp.enable("html")
