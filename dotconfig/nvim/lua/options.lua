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
