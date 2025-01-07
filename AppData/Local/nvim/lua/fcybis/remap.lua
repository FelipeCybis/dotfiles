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

map("n", "<leader>rg", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "[r]eplace word [g]lobally" })
map("n", "<leader>rc", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<Left><Left><Left>",
    { desc = "[r]eplace word intera[c]tively" })
map("n", "<leader>rf", ":.,$s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<Left><Left><Left>",
    { desc = "[r]eplace word [f]orward interactively" })
map("v", "<leader>rg", '"hy:%s/<C-r>h/<C-r>h/gI<Left><Left><Left>',
    { desc = "[r]eplace selected text [g]lobally" })
map("v", "<leader>rf", '"hy:.,$s/<C-r>h/<C-r>h/gc<Left><Left><Left>',
    { desc = "[r]eplace visual [f]orward interactively" })

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
