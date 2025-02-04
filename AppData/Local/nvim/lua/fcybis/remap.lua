vim.g.mapleader = " "
local map = vim.keymap.set

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<Esc>q', '<C-\\><C-n>:q<CR>', { desc = 'Quit terminal buffer' })

-- Move lines up and down while in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Move around buffer
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- paste over without replacing the register
map("x", "p", "\"_dP")

-- delete without replacing the register
map("x", "<leader>d", "\"_d")

-- yank it to clipboard
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

-- paste from clipboard
map("n", "<leader>p", "\"*p")
map("v", "<leader>p", "\"*p")

local replace_pattern = function(mode, flag)
  local init_pattern = ":%" -- current file
  if flag == "forward" then
    init_pattern = ":.,$"   -- from current line to end of file
  elseif flag == "line" then
    init_pattern = ":"      -- current line
  end
  if mode == "v" then
    init_pattern = '"hy' .. init_pattern -- copy visual selection to register h
  end

  local replace_selection = "\\<<C-r><C-w>\\>/<C-r><C-w>" -- whole word
  if mode == "v" then
    replace_selection = "<C-r>h/<C-r>h"                   -- visual selection
  end

  local end_flag = "/gc" -- confirm each substitution
  if flag == "global" or flag == "line" then
    end_flag = "/gI"     -- global, case-sensitive
  end


  return init_pattern .. "s/" .. replace_selection .. end_flag .. "<Left><Left><Left>"
end
-- Replace_pattern
map("n", "<leader>rwg", replace_pattern("n", "global"), { desc = "[r]eplace [w]ord or selection: [g]lobally" })
map("n", "<leader>rwi", replace_pattern("n", "interactive"), { desc = "[r]eplace [w]ord or selection: [i]nteractively" })
map("n", "<leader>rwf", replace_pattern("n", "forward"), { desc = "[r]eplace [w]ord or selection: [f]orward" })
map("n", "<leader>rwl", replace_pattern("n", "line"), { desc = "[r]eplace [w]ord or selection: current [l]ine" })
map("v", "<leader>rwg", replace_pattern("v", "global"), { desc = "[r]eplace [w]ord or selection: [g]lobally" })
map("v", "<leader>rwi", replace_pattern("v", "interactive"), { desc = "[r]eplace [w]ord or selection: [i]nteractively" })
map("v", "<leader>rwf", replace_pattern("v", "forward"), { desc = "[r]eplace [w]ord or selection: [f]orward" })
map("v", "<leader>rwl", replace_pattern("v", "line"), { desc = "[r]eplace [w]ord or selection: current [l]ine" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save file faster using leader key
map("n", "<leader>w", ":w<CR>")

-- Quit buffer faster and quit window
map("n", "<leader>q", ":bd<CR>")
map("n", "<leader>Q", ":q<CR>")

-- Move cursor to next line even if it is wrapped
map("n", "j", "gj")
map("n", "k", "gk")

-- Keep visual mode after indenting < or >
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Lua testing and maps
map("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Source current file" })
map("n", "<leader>xl", ":.lua<cr>", { desc = "R[x]un [l]ua line" })
map("v", "<leader>xl", ":lua<cr>", { desc = "R[x]un [l]ua: visual sel" })

map("n", "<leader>cd", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "[c]ode: [d]iagnostics popup" })
