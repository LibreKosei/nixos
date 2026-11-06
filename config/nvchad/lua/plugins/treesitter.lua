return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        after = function()
            pcall(function()
              dofile(vim.g.base46_cache .. "syntax")
              dofile(vim.g.base46_cache .. "treesitter")
            end)

            local opts = require("nvchad.configs.treesitter")
            opts.auto_install = false
            opts.ensure_installed = {
                "lua", 
                "luadoc", 
                "printf", 
                "vim", 
                "vimdoc" 
            }
            require("nvim-treesitter.configs").setup(opts)

            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
                    pcall(vim.treesitter.start, buf)
                end
            end
        end,
    }
}
