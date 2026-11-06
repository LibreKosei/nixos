return {
  {
    "telescope-nvim",
    cmd = "Telescope",
    after = function()
      dofile(vim.g.base46_cache .. "telescope")
      require("telescope").setup(require "nvchad.configs.telescope")
    end,
  },
}
