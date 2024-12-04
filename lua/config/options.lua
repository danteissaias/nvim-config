vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.foldtext = ""
vim.o.foldlevel = 99

vim.o.swapfile = false
vim.o.backupcopy = "yes"

vim.o.updatetime = 200
vim.o.timeoutlen = 300

vim.o.wrap = true

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
