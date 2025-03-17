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
      local current_wezterm_pane_id = wezterm.get_current_pane()
      vim.cmd('wincmd ' .. direction)
      local new_nvim_win = vim.api.nvim_get_current_win()

      -- if nvim window did not change, try wezterm pane
      if current_nvim_win == new_nvim_win then
        -- check if there is a new pane to given direction
        local next_pane_id = wezterm.get_pane_direction(wez_direction, current_wezterm_pane_id)
        -- if no pane and direction is 'h' or 'l', try tabs
        if next_pane_id == nil and (direction == "h" or direction == "l") then
          local rel_tab = 1
          if direction == "h" then
            rel_tab = -1
          end
          wezterm.switch_tab.relative(rel_tab)
        else
          -- there was a new pane, go to this pane
          wezterm.switch_pane.direction(wez_direction, current_wezterm_pane_id)
        end
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
