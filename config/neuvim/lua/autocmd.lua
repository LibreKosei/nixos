-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = { 'TelescopePrompt', 'TelescopeResults', 'NvimTree' },
--     callback = function (args)
--         require('colorizer').detach_from_buffer(args.buf)
--     end
-- })

-- Persistence
local grp = vim.api.nvim_create_augroup("RememberFolds", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
  group = grp,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! mkview")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = grp,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      -- defer so ufo has attached and created its folds first
      vim.schedule(function() vim.cmd("silent! loadview") end)
    end
  end,
})
