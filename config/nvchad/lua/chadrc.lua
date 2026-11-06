local M = {}

M.base46 = {
	  theme = "everblush",
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.nvdash = {
    load_on_startup = true,
    buttons = {
        { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
        { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
        { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
        { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
        { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    },
}

M.term = {
  float = {
      relative = "editor",
      height = 0.65,
      width = 0.7,
  },
}

return M
