vim.opt.nu = true
vim.opt.relativenumber = true

vim.o.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
vim.o.shellcmdflag =
'-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
vim.o.shellquote = ''
vim.o.shellxquote = ''

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn = "89"
vim.opt.textwidth = 88

vim.g.mapleader = " "

vim.g.python3_host_prog = "C:\\Users\\felip\\AppData\\Local\\nvim\\nvim_venv\\Scripts\\python.exe"
