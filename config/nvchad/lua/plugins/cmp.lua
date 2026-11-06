return {
    { "cmp-nvim-lsp",   dep_of = "nvim-cmp" },
    { "cmp-nvim-lua",   dep_of = "nvim-cmp" },  -- used by the nvim_lua source
    { "cmp-buffer",     dep_of = "nvim-cmp" },
    { "cmp-async-path", dep_of = "nvim-cmp" },
    { "cmp_luasnip",    dep_of = "nvim-cmp" },
    { "luasnip",        dep_of = "nvim-cmp" },
    {
        "nvim-cmp",
        event = "InsertEnter",
        after = function() 
            dofile(vim.g.base46_cache .. "cmp")
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local opts = "nvchad.configs.cmp"
            opts.completion.autocomplete = false
            opts.preselect = cmp.PreselectMode.None
            
            opts.mapping["<C-Space>"] = cmp.mapping.complete()
            opts.mapping["<CR>"] = cmp.mapping.confirm { select = false }

            cmp.setup(opts)
        end,
    }
}
