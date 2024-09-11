local wezterm = require('wezterm')

return_args = {}

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

local direction_mapping = {
    ["h"] = "Left",
    ["j"] = "Down",
    ["k"] = "Up",
    ["l"] = "Right",
}

local function move_across_tabs_compat(window, pane, direction)
    -- window:perform_action(wezterm.action_callback(function(window, pane)
    local next_pane = pane:tab():get_pane_direction(direction_mapping[direction])
    local mux_window = window:mux_window()
    -- If there is a pane to the direction we want to move to, activate it
    if next_pane then
        return wezterm.action_callback(function() next_pane:activate() end)
        -- There is no next pane, but maybe there are tabs to the left or right
    end
    if direction == "h" or direction == "l" then
        for i, tab in ipairs(mux_window:tabs_with_info()) do
            if tab.tab:tab_id() == pane:tab():tab_id() then
                local next_tab_index = i + 1
                if direction == "h" then
                    next_tab_index = i - 1
                    if next_tab_index <= 0 then
                        next_tab_index = #mux_window:tabs()
                    end
                elseif next_tab_index > #mux_window:tabs() then
                    next_tab_index = 1
                end

                local next_tab = mux_window:tabs_with_info()[next_tab_index]
                -- if there is a tab to the directino we want to move to, activate it
                if next_tab then
                    return wezterm.action_callback(function() next_tab.tab:activate() end)
                end
            end
        end
    else
        -- If there is no pane to the direction we want to move to, create a new pane
        return wezterm.action_callback(function() wezterm.log_info("Either on top or bottom of window.") end)
    end
end

local function move_neovim_compat(window, pane, direction)
    local is_nvim = pane:get_user_vars().NVIM_WEZTERM

    if is_nvim then
        window:perform_action(
            wezterm.action.Multiple {
                wezterm.action.SendKey { key = direction, mods = "ALT" },
            }, pane)
    else
        window:perform_action(move_across_tabs_compat(window, pane, direction), pane)
    end
end
return_args.move_neovim_compat = move_neovim_compat

local function fullscreen_neovim_compat(window, pane)
    local is_nvim = pane:get_user_vars().NVIM_WEZTERM

    if is_nvim then
        window:perform_action(
            wezterm.action.Multiple {
                wezterm.action.SendKey { key = "f", mods = "CTRL" },
            }, pane)
    else
        window:perform_action(wezterm.action.TogglePaneZoomState, pane)
    end
end
return_args.fullscreen_neovim_compat = fullscreen_neovim_compat


return return_args
