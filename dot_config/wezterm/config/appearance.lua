local wezterm = require('wezterm')

-- show the domain and workspace in the status area, for quicker and easier sanity checking
wezterm.on('update-right-status', function(window, pane)
    local meta = pane:get_metadata() or {}

    local right_status = " " .. pane:get_domain_name() .. " / " .. window:active_workspace() .. " "
    if meta.is_tardy then
        local secs = meta.since_last_response_ms / 1000.0
        right_status = right_status .. string.format('tardy: %5.1fs⏳', secs)
    end
    window:set_right_status(right_status)
end)

return {
    color_scheme = 'Catppuccin Frappe',
    -- tab bar
    -- hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,

    -- font
    font = wezterm.font("MesloLGS NF"),

    -- Allow tiling window manager do its thing and not wezterm
    adjust_window_size_when_changing_font_size = false,

    -- Make it look like tabs, with better GUI controls
    use_fancy_tab_bar = false,
    -- Don't let any individual tab name take too much room
    tab_max_width = 32,
    colors = {
        tab_bar = {
            active_tab = {
                -- I use a solarized dark theme; this gives a teal background to the active tab
                fg_color = '#073642',
                bg_color = '#00ff00',
            }
        },
        split = "#00ff00",
    },
    -- Switch to the last active tab when I close a tab
    switch_to_last_active_tab_when_closing_tab = true,

    inactive_pane_hsb = {
        saturation = 0.4,
        brightness = 0.9,
    },
}
