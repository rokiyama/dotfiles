vim.cmd("autocmd!")

vim.opt.number = true
vim.opt.mouse = a
vim.opt.clipboard:append("unnamedplus")
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.smartcase = true
vim.opt.textwidth = 0
vim.opt.foldlevelstart = 10
vim.opt.list = true
vim.opt.listchars = "tab:»-,trail:-,extends:»,precedes:«,nbsp:%"
vim.cmd("highlight Whitespace cterm=NONE ctermfg=16 guifg=gray")

-- restore-cursor
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  callback = function()
    vim.cmd('normal! g`"zv')
  end
})

vim.g.mapleader = " "
vim.keymap.set({'i', 'c'}, '<C-a>', '<Home>')
vim.keymap.set({'i', 'c'}, '<C-e>', '<End>')
vim.keymap.set({'i', 'c'}, '<C-b>', '<Left>')
vim.keymap.set({'i', 'c'}, '<C-f>', '<Right>')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set({'i', 'c'}, '<C-d>', '<Del>')
vim.keymap.set({'i', 'c'}, '<M-b>', '<C-Left>')
vim.keymap.set({'i', 'c'}, '<M-f>', '<C-Right>')
vim.keymap.set({'i', 'c'}, '<M-d>', '<Del>')

vim.keymap.set('n', '<A-v>', '$v^')
vim.keymap.set('i', 'jj', '<ESC>')

vim.keymap.set('n', '<leader>/', '/\\v')
vim.keymap.set('n',  '<C-n>', ':nohlsearch<CR>')
