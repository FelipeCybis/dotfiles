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

function is_an_editor(name)
    return os.getenv("NVIM") == nil
end

local keys = {
    {
        key = 'L',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.DisableDefaultAssignment,
    },
    {
        key = 'K',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.DisableDefaultAssignment,
    },
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
        mods = 'ALT',
        action = wezterm.action_callback(function(window, pane)
            local is_nvim = pane:get_user_vars().NVIM_WEZTERM

            if is_nvim then
                window:perform_action(
                    wezterm.action.Multiple {
                        wezterm.action.SendKey { key = "h", mods = "ALT" },
                    }, pane)
            else
                window:perform_action(wezterm.action.ActivatePaneDirection 'Left', pane)
            end
        end)
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action_callback(function(window, pane)
            local is_nvim = pane:get_user_vars().NVIM_WEZTERM

            if is_nvim then
                window:perform_action(
                    wezterm.action.Multiple {
                        wezterm.action.SendKey { key = "l", mods = "ALT" },
                    }, pane)
            else
                window:perform_action(wezterm.action.ActivatePaneDirection 'Right', pane)
            end
        end)
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action_callback(function(window, pane)
            local is_nvim = pane:get_user_vars().NVIM_WEZTERM

            if is_nvim then
                window:perform_action(
                    wezterm.action.Multiple {
                        wezterm.action.SendKey { key = "k", mods = "ALT" },
                    }, pane)
            else
                window:perform_action(wezterm.action.ActivatePaneDirection 'Up', pane)
            end
        end)
    },
    {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action_callback(function(window, pane)
            local is_nvim = pane:get_user_vars().NVIM_WEZTERM

            if is_nvim then
                window:perform_action(
                    wezterm.action.Multiple {
                        wezterm.action.SendKey { key = "j", mods = "ALT" },
                    }, pane)
            else
                window:perform_action(wezterm.action.ActivatePaneDirection 'Down', pane)
            end
        end)
    },
    {
        key = 'H',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.AdjustPaneSize { 'Left', 2 },
    },
    {
        key = 'J',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.AdjustPaneSize { 'Down', 2 },
    },
    { key = 'K', mods = 'SHIFT|CTRL', action = wezterm.action.AdjustPaneSize { 'Up', 2 } },
    {
        key = 'L',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },
    {
        key = 'q',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
        key = 'q',
        mods = 'CTRL',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    ---- BACKGROUND OPACITY
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
    ---- UTILS
    {
        key = 'r',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },

    ---- DOMAINES AND WORKSPACES
    -- Attaches the current pane to associated domain
    {
        key = 'a',
        mods = 'LEADER',
        action = wezterm.action.AttachDomain 'mux',
    },
    -- Detaches the domain associated with the current pane
    {
        key = 'd',
        mods = 'LEADER',
        action = wezterm.action.DetachDomain 'CurrentPaneDomain',
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = wezterm.action.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter new name for workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
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
        },
    },
    -- Show list of workspaces
    {
        key = 'Space',
        mods = 'LEADER',
        action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    -- Launch menu
    {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ShowLauncher,
    },
    ---- TABS
    {
        key = ',',
        mods = 'LEADER',
        action = wezterm.action.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(
                function(window, pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end
            ),
        },
    },
    {
        key = 'f',
        mods = 'LEADER',
        action = wezterm.action.ShowTabNavigator,
    },
}


return {
    leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = keys,
    window_background_opacity = window_background_opacity,
}
