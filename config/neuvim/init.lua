--- core
require("options")
require("keybinds")
require("colorscheme")
require('autocmd')

--- Plugins 
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.which-key")
require("plugins.blink-cmp")
require("plugins.nvim-autopairs")
require("plugins.treesitter")
require("plugins.toggleterm")
require("plugins.fzf")
require("plugins.nvim-tree")
require("plugins.gitsigns")
require('plugins.colorizer')
require('plugins.markview')
require('plugins.obsidian')
require('plugins.vimtex')
require('plugins.luasnip')


--- Language Server Protocols 
require("lsp.lua_ls")
require("lsp.nixd")
require('lsp.pyright')
require('lsp.rust_analyzer')
require('lsp.qmlls')
require('lsp.markdown-oxide')
require('lsp.html')
require('lsp.cssls')
require('lsp.ts_ls')
require('lsp.hls')
require('lsp.latex')

--- Lua
vim.cmd.colorscheme("pasteldark")
