vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function ()
        vim.lsp.enable("rust_analyzer")
        vim.treesitter.start()
    end
})
