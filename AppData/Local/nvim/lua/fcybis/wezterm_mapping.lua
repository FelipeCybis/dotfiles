-- Define a Lua function to handle checking and moving
WeztermNvim = {}

-- General function to move and check in any direction
function WeztermNvim.move(direction, wez_direction)
    local current_win = vim.api.nvim_get_current_win()
    vim.cmd('wincmd ' .. direction)
    local new_win = vim.api.nvim_get_current_win()

    if current_win == new_win then
        os.execute('wezterm cli activate-pane-direction ' .. wez_direction)
    end
end

-- Key mappings for all directions
vim.keymap.set('n', '<A-h>', function()
    WeztermNvim.move('h', 'Left')
end, { noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', function()
    WeztermNvim.move('l', 'Right')
end, { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', function()
    WeztermNvim.move('k', 'Up')
end, { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', function()
    WeztermNvim.move('j', 'Down')
end, { noremap = true, silent = true })
