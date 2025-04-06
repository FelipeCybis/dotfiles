return {
  "willothy/wezterm.nvim",
  config = function()
    local wezterm = require("wezterm")
    -- Set/remove a user variable so Wezterm knows we are in nvim
    wezterm.set_user_var("NVIM_WEZTERM", true)
    vim.api.nvim_create_autocmd("ExitPre", {
      callback = function() wezterm.set_user_var("NVIM_WEZTERM", false) end, -- the function to call
    })


    -- General function to move and check in any direction
    local function move(direction, wez_direction)
      local current_nvim_win = vim.api.nvim_get_current_win()
      vim.cmd('wincmd ' .. direction)
      local new_nvim_win = vim.api.nvim_get_current_win()

      -- if nvim window did not change, try wezterm pane
      if current_nvim_win == new_nvim_win then
        -- wezterm nvim plugin does not handles things well when not on local (ssh, etc))
        -- we handle things on wezterm config
        wezterm.set_user_var("WEZTERM_MOVE", direction)
      end
    end

    -- Key mappings for all directions
    vim.keymap.set('n', '<A-h>', function()
      move('h', 'Left')
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-l>', function()
      move('l', 'Right')
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-k>', function()
      move('k', 'Up')
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-j>', function()
      move('j', 'Down')
    end, { noremap = true, silent = true })
  end,
}
