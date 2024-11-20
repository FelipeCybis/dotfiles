vim.g.mapleader = " "

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<Esc>q', '<C-\\><C-n>:q<CR>', { desc = 'Quit terminal buffer' })

-- Move lines up and down while in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move around buffer
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over without replacing the register
vim.keymap.set("x", "p", "\"_dP")

-- delete without replacing the register
vim.keymap.set("x", "<leader>d", "\"_d")

-- yank it to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- paste from clipboard
vim.keymap.set("n", "<leader>p", "\"*p")
vim.keymap.set("v", "<leader>p", "\"*p")

vim.keymap.set("n", "<leader>rg", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "[r]eplace word [g]lobally" })
vim.keymap.set("n", "<leader>rc", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<Left><Left><Left>",
    { desc = "[r]eplace word intera[c]tively" })
vim.keymap.set("n", "<leader>rf", ":.,$s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<Left><Left><Left>",
    { desc = "[r]eplace word [f]orward interactively" })
vim.keymap.set("v", "<leader>rg", '"hy:%s/<C-r>h/<C-r>h/gI<Left><Left><Left>',
    { desc = "[r]eplace selected text [g]lobally" })
vim.keymap.set("v", "<leader>rf", '"hy:%s/<C-r>h/<C-r>h/gc<Left><Left><Left>',
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
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Quit buffer faster and quit window
vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>Q", ":q<CR>")

-- Move cursor to next line even if it is wrapped
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Keep visual mode after indenting < or >
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
