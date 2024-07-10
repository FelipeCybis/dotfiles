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
    { key = 'F3', mods = 'NONE', action = wezterm.action.ShowLauncher },
    -- PANES
    {
        key = 'v',
        mods = 'ALT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 's',
        mods = 'ALT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'h',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'H',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'J',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
    { key = 'K', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
    {
        key = 'L',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'q',
        mods = 'ALT',
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

}


return {
    leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 1000 },
    keys = keys,
    window_background_opacity = window_background_opacity,
}


