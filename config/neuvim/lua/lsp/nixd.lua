vim.lsp.config('nixd', {
    cmd = { 'nixd' },
    filetypes = { 'nix' },
    root_markers = { 'flake.nix', '.git' },
    settings = {
        nixd = {
            formatting = {
                command = { "nixfmt" },
            },
        },
        nixpkgs = {
            expr = 'import (builtins.getFlake "github:LibreKosei/dots").inputs.nixpkgs {}',
        },
        options = {
            nixos = {
                expr = '(builtins.getFlake "github:LibreKosei/dots").nixosConfigurations.kosei.options',
            },
            home_manager = {
                expr = '(builtins.getFlake "github:LibreKosei/dots").homeConfigurations.kosei.options',
            },
        },
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "nix",
    callback = function ()
        vim.lsp.enable("nixd")
        vim.treesitter.start()
    end
})
