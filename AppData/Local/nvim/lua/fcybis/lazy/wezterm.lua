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

      -- if nvim window did not change, check for tabs before trying wezterm
      if current_nvim_win == new_nvim_win then
        local current_tab = vim.api.nvim_get_current_tabpage()
        local list_of_tabpages = vim.api.nvim_list_tabpages()

        -- tabpages are numbered but may have changed position, find current position
        local current_tab_position
        for i, tabpage in ipairs(list_of_tabpages) do
          if tabpage == current_tab then
            current_tab_position = i
          end
        end

        local tab_changed = false
        if direction == 'h' or direction == 'l' then
          local next_tab = direction == 'h' and current_tab_position - 1 or current_tab_position + 1
          if list_of_tabpages[next_tab] ~= nil then
            vim.api.nvim_set_current_tabpage(next_tab)
            tab_changed = true
          end
        end

        -- if tab did not change, try wezterm pane
        if not tab_changed then
          -- wezterm nvim plugin does not handles things well when not on local (ssh, etc))
          -- we handle things on wezterm config
          wezterm.set_user_var("WEZTERM_MOVE", direction)
        end
      end
    end

    -- Key mappings for all directions
    vim.keymap.set('n', '<A-h>', function()
      move('h', 'Left')
    end, { noremap = true, silent = true, desc = "Move to left (Wezterm compatible)" })
    vim.keymap.set('n', '<A-l>', function()
      move('l', 'Right')
    end, { noremap = true, silent = true, desc = "Move to right (Wezterm compatible)" })
    vim.keymap.set('n', '<A-k>', function()
      move('k', 'Up')
    end, { noremap = true, silent = true, desc = "Move to up (Wezterm compatible)" })
    vim.keymap.set('n', '<A-j>', function()
      move('j', 'Down')
    end, { noremap = true, silent = true, desc = "Move to down (Wezterm compatible)" })
  end,
}
