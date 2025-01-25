local vim = vim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set python neovim path
if vim.fn.has('win32') == 1 then
    vim.g.python3_host_prog = vim.fn.stdpath('config') .. "\\nvim_venv\\Scripts\\python.exe"
else
    vim.g.python3_host_prog = vim.fn.stdpath('config') .. "/nvim_venv/bin/python3"
end

vim.opt.nu = true
vim.opt.relativenumber = true

-- Save undo history
vim.opt.undofile = true

if vim.fn.has('win32') == 1 then
    -- Set stuff to work well on powershell
    vim.opt.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
    vim.opt.shellcmdflag =
    '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
end

-- Indentation and spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn = "89"
vim.opt.textwidth = 88

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on
vim.opt.cursorline = true

if os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil then
    local function my_paste(_)
        return function(_)
            local content = vim.fn.getreg('"')
            return vim.split(content, '\n')
        end
    end

    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy "+",
            ["*"] = require("vim.ui.clipboard.osc52").copy "*",
        },
        paste = {
            ["+"] = my_paste "+",
            ["*"] = my_paste "*",
        },
    }
end

vim.lsp.set_log_level("off")
