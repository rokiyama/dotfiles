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

vim.keymap.set('n', '<C-n>', ':nohlsearch<CR>')

vim.keymap.set('n', '<leader>m', '@a')

if vim.g.vscode then
  vim.keymap.set("n", "gD", "<Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>")
  vim.keymap.set("n", "gr", "<Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>")
  vim.keymap.set("n", "<leader>b", "<Cmd>call VSCodeNotify('bookmarks.toggle')<CR>")
else
end
