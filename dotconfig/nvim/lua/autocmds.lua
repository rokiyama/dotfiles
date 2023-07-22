vim.cmd("autocmd!")

-- restore-cursor
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  callback = function()
    vim.cmd('normal! g`"zv')
  end
})
