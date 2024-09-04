local wezterm = require('wezterm')

-- Initial opacity value
local opacity = 1.0;
local window_background_opacity = opacity;

wezterm.on('increase-opacity', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    opacity = math.min(1.0, opacity + 0.1)
    overrides.window_background_opacity = opacity;
    window:set_config_overrides(overrides)
end
)

wezterm.on('decrease-opacity', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    opacity = math.max(0.1, opacity - 0.1)
    overrides.window_background_opacity = opacity;
    window:set_config_overrides(overrides)
end
)

local keys = {
    { key = 'Space', mods = 'LEADER',   action = wezterm.action.ShowLauncher },
    -- PANES
    {
        key = 'v',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'h',
        mods = 'ALT|CTRL',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'j',
        mods = 'ALT|CTRL',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
    { key = 'k',     mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
    {
        key = 'l',
        mods = 'ALT|CTRL',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'q',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- BACKGROUND OPACITY
    {
        mods = 'CTRL|SHIFT',
        key = 'o',
        action = wezterm.action.EmitEvent 'increase-opacity',
    },
    {
        mods = 'CTRL|SHIFT',
        key = 'i',
        action = wezterm.action.EmitEvent 'decrease-opacity',
    },
    -- UTILS
    {
        key = 'r',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
    -- Detaches the domain associated with the current pane
    {
        key = 'D',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.DetachDomain 'CurrentPaneDomain',
    },
}


return {
    leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = keys,
    window_background_opacity = window_background_opacity,
}
