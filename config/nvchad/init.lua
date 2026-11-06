vim.g.mapleader = " "
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"

if not vim.uv.fs_stat(vim.g.base46_cache .. "defaults") then
    require("base46").load_all_highlights()
end

require("nvchad")

require("lz.n").load("plugins")

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "syntax")
dofile(vim.g.base46_cache .. "treesitter")

require("options")
require("nvchad.autocmds")

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)   -- silently skipped if no parser exists
    end,
})

vim.schedule(function() require("mappings") end)
