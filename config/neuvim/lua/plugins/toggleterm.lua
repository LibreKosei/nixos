require("lz.n").load {
    "toggleterm.nvim",
    keys = {
        {
            "<A-h>",
            "<CMD>ToggleTerm direction=horizontal<CR>",
            desc = "ToggleTerm open horizontally",
            mode = { 'n', 't' }
        },
        {
            "<A-v>",
            "<CMD>ToggleTerm direction=vertical<CR>",
            desc = "ToggleTerm open vertically",
            mode = { 'n', 't' }
        },
        {
            "<A-f>",
            "<CMD>ToggleTerm direction=float<CR>",
            desc = "ToggleTerm open float",
            mode = { 'n', 't' }
        }
    },
    after = function ()
        require("toggleterm").setup({
            shade_terminals = false,
            shell = vim.o.shell,
        })
    end
}
