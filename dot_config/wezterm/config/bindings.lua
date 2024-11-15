local wezterm = require('wezterm') --[[@as Wezterm]]
local nvim_compat = require('config.neovim')

-- Initial opacity value
local opacity = 1.0;
local window_background_opacity = opacity;

---@param window Window
wezterm.on('increase-opacity', function(window, _)
    local overrides = window:get_config_overrides() or {}
    opacity = math.min(1.0, opacity + 0.1)
    overrides.window_background_opacity = opacity;
    window:set_config_overrides(overrides)
end
)

---@param window Window
wezterm.on('decrease-opacity', function(window, _)
    local overrides = window:get_config_overrides() or {}
    opacity = math.max(0.1, opacity - 0.1)
    overrides.window_background_opacity = opacity;
    window:set_config_overrides(overrides)
end
)

---@alias WeztermAction KeyAssignment | Action | fun(): KeyAssignment

---@param key string The key to be used in the keybinding
---@param mods string The modifiers to be used in the keybinding
---@param action WeztermAction The action to be executed when the keybinding is triggered
---@return table<string, string, Action> table The keybinding object
local function make_keybinding(key, mods, action)
    return {
        key = key,
        mods = mods,
        action = action,
    }
end

---Wraps a wezterm callback function with an optional argument
---@param callback function The callback function to be wrapped
---@param arg string|nil An optional argument to be passed to the callback function
---@return Action action The wrapped callback function
local function wrap_wez_callback(callback, arg)
    local func = function(window, pane)
        callback(window, pane)
    end
    if arg then
        func = function(window, pane)
            callback(window, pane, arg)
        end
    end
    return wezterm.action_callback(func)
end

local keys = {
    make_keybinding('L', 'CTRL|SHIFT', wezterm.action.DisableDefaultAssignment),
    make_keybinding('K', 'CTRL|SHIFT', wezterm.action.DisableDefaultAssignment),
    -- PANES
    make_keybinding('v', 'LEADER', wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }),
    make_keybinding('s', 'LEADER', wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }),
    make_keybinding('h', 'ALT', wrap_wez_callback(nvim_compat.move_neovim_compat, 'h')),
    make_keybinding('l', 'ALT', wrap_wez_callback(nvim_compat.move_neovim_compat, 'l')),
    make_keybinding('k', 'ALT', wrap_wez_callback(nvim_compat.move_neovim_compat, 'k')),
    make_keybinding('j', 'ALT', wrap_wez_callback(nvim_compat.move_neovim_compat, 'j')),
    make_keybinding('H', 'SHIFT|CTRL', wezterm.action.AdjustPaneSize { 'Left', 2 }),
    make_keybinding('J', 'SHIFT|CTRL', wezterm.action.AdjustPaneSize { 'Down', 2 }),
    make_keybinding('K', 'SHIFT|CTRL', wezterm.action.AdjustPaneSize { 'Up', 2 }),
    make_keybinding('L', 'SHIFT|CTRL', wezterm.action.AdjustPaneSize { 'Right', 2 }),
    make_keybinding('q', 'LEADER', wezterm.action.CloseCurrentPane { confirm = true }),
    ---- BACKGROUND OPACITY
    make_keybinding('o', 'CTRL|SHIFT', wezterm.action.EmitEvent 'increase-opacity'),
    make_keybinding('i', 'CTRL|SHIFT', wezterm.action.EmitEvent 'decrease-opacity'),
    ---- FULLSCREEN
    make_keybinding('f', 'CTRL', wrap_wez_callback(nvim_compat.fullscreen_neovim_compat)),
    ---- UTILS
    make_keybinding('r', 'CTRL|SHIFT', wezterm.action.ReloadConfiguration),

    ---- DOMAINES AND WORKSPACES
    -- Attaches the current pane to associated domain
    make_keybinding('a', 'LEADER', wezterm.action.AttachDomain 'mux'),
    -- Detaches the domain associated with the current pane
    make_keybinding('d', 'LEADER', wezterm.action.DetachDomain 'CurrentPaneDomain'),
    make_keybinding('w', 'LEADER', wezterm.action.PromptInputLine {
        description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Fuchsia' } },
            { Text = 'Enter new name for workspace' },
        },
        action = wezterm.action_callback(function(window, _, line)
            -- line will be `nil` if they hit escape without entering anything
            -- An empty string if they just hit enter
            -- Or the actual line of text they wrote
            if line then
                wezterm.mux.rename_workspace(
                    window:mux_window():get_workspace(),
                    line
                )
            end
        end),
    }),
    -- Show list of workspaces
    make_keybinding('Space', 'LEADER', wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }),
    -- Launch menu
    make_keybinding('p', 'LEADER', wezterm.action.ShowLauncher),
    ---- TABS
    make_keybinding(',', 'LEADER', wezterm.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(
            function(window, _, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end
        ),
    }),
    make_keybinding('f', 'LEADER', wezterm.action.ShowTabNavigator),
}


return {
    leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = keys,
    window_background_opacity = window_background_opacity,
}
