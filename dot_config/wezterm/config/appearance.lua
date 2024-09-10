local wezterm = require('wezterm')

-- show the domain and workspace in the status area, for quicker and easier sanity checking
wezterm.on("update-right-status", function(window, pane)
    window:set_right_status(pane:get_domain_name() .. " / " .. window:active_workspace())
end)

return {
    color_scheme = 'Catppuccin Frappe',
    -- tab bar
    -- hide_tab_bar_if_only_one_tab = true,

    -- font
    font = wezterm.font("MesloLGS NF"),
    -- Make it look like tabs, with better GUI controls
    use_fancy_tab_bar = true,
    -- Don't let any individual tab name take too much room
    tab_max_width = 32,
    colors = {
        tab_bar = {
            active_tab = {
                -- I use a solarized dark theme; this gives a teal background to the active tab
                fg_color = '#073642',
                bg_color = '#2aa198',
            }
        },
        split = "#2aa198",
    },
    -- Switch to the last active tab when I close a tab
    switch_to_last_active_tab_when_closing_tab = true,

    inactive_pane_hsb = {
        saturation = 0.4,
        brightness = 0.9,
    },
}
