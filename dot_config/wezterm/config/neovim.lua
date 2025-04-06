local wezterm = require('wezterm') --[[@as Wezterm]]

local direction_mapping = {
  ["h"] = "Left",
  ["j"] = "Down",
  ["k"] = "Up",
  ["l"] = "Right",
}

--- Moves focus across tabs or panes in a specified direction.
--- If a pane exists in the specified direction, it activates that pane.
--- If no pane exists, it attempts to move across tabs in the specified direction.
--- If neither is possible, it logs a message.
---
--- @param window Window The current window object.
--- @param pane Pane The current pane object.
--- @param direction string The direction to move ("h" for left, "l" for right).
--- @return KeyAssignment A wezterm action to execute the movement.
local function move_across_tabs_compat(window, pane, direction)
  -- pane:tab() may be nil if the pane is an overlay (debug, for example)
  if pane:tab() then
    local next_pane = pane:tab():get_pane_direction(direction_mapping[direction])
    -- If there is a pane to the direction we want to move to, activate it
    if next_pane then
      return wezterm.action_callback(function() next_pane:activate() end)
      -- There is no next pane, but maybe there are tabs to the left or right
    end
  end

  local mux_window = window:mux_window()
  if direction == "h" or direction == "l" then
    for i, tab in ipairs(mux_window:tabs_with_info()) do
      if tab.is_active then
        -- tabs are 1-indexed, but the table is 0-indexed
        local next_tab_index = tab.index + 1 + 1
        if direction == "h" then
          next_tab_index = tab.index + 1 - 1
        end

        -- moving left, actually
        if next_tab_index <= 0 then
          next_tab_index = #mux_window:tabs()
        elseif next_tab_index > #mux_window:tabs() then
          next_tab_index = 1
        end

        local next_tab = mux_window:tabs_with_info()[next_tab_index]
        -- if there is a tab to the directino we want to move to, activate it
        if next_tab then
          return wezterm.action_callback(function()
            next_tab.tab:activate()
          end)
        end
      end
    end
  end
  -- If there is no pane to the direction we want to move to, create a new pane
  return wezterm.action_callback(function()
    wezterm.log_info("Either on top or bottom of the window.")
  end)
end

---@param window Window
---@param pane Pane
---@param direction string
local function move_neovim_compat(window, pane, direction)
  local is_nvim = pane:get_user_vars().NVIM_WEZTERM

  if is_nvim == "true" then
    window:perform_action(
      wezterm.action.Multiple {
        wezterm.action.SendKey { key = direction, mods = "ALT" },
      }, pane)
  else
    window:perform_action(move_across_tabs_compat(window, pane, direction), pane)
  end
end

---@param window Window
---@param pane Pane
local function fullscreen_neovim_compat(window, pane)
  local is_nvim = pane:get_user_vars().NVIM_WEZTERM

  if is_nvim == "true" then
    window:perform_action(
      wezterm.action.Multiple {
        wezterm.action.SendKey { key = "f", mods = "CTRL" },
      }, pane)
  else
    window:perform_action("TogglePaneZoomState", pane)
  end
end

wezterm.on('user-var-changed', function(window, pane, name, value)
  wezterm.log_info("User var changed", name, value)
  if name == "WEZTERM_MOVE" then
    window:perform_action(move_across_tabs_compat(window, pane, value), pane)
  end
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while (number_value > 0) do
        window:perform_action("IncreaseFontSize", pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action("ResetFontSize", pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    elseif number_value ~= nil then
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

local return_args = {}
return_args.move_neovim_compat = move_neovim_compat
return_args.fullscreen_neovim_compat = fullscreen_neovim_compat

return return_args
