require "nvchad.options"

-- add yours here!

local o = vim.o
o.shell = "zsh"
o.tabstop = 4
o.softtabstop = 0
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true
o.selectmode = ""
require("nvim-tree").setup({
    view = {
        adaptive_size = true;
    };
})

-- o.cursorlineopt ='both' -- to enable cursorline!
