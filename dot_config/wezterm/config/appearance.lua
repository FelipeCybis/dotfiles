local wezterm = require('wezterm') --[[@as Wezterm]]

wezterm.on("update-right-status", function(window, pane)
    -- Each element holds the text for a cell in a "powerline" style << fade
    local cells = {};

    -- metadata for the pane if it is a MuxPane
    local meta = pane:get_metadata() or {}

    -- An entry for each battery (typically 0 or 1 battery)
    for i, b in ipairs(wezterm.battery_info()) do
        battery_info = string.format("%.0f%%", b.state_of_charge * 100)
        if i == 1 and meta.is_tardy then
            local secs = meta.since_last_response_ms / 1000.0
            battery_info = battery_info .. string.format('tardy: %5.1fs⏳', secs)
        end
        table.insert(cells, battery_info)
    end

    -- I like my date/time in this style: "Mar 3 08:14:20"
    local date = wezterm.strftime("%b %-d %H:%M:%S");
    table.insert(cells, date);

    -- The workspace and domain name are only shown if domain is not local
    local domain_name = pane:get_domain_name()
    if domain_name ~= "local" then
        table.insert(cells, "w: " .. window:active_workspace())
        table.insert(cells, "d: " .. domain_name)
    end

    -- The powerline < symbol
    local LEFT_ARROW = utf8.char(0xe0b3);
    -- The filled in variant of the < symbol
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- Color palette for the backgrounds of each cell
    local colors = {
        "#99ff99",
        "#00ff00",
        "#99ff99",
        "#00ff00",
    };

    -- Foreground color for the text across the fade
    local text_fg = "#1a1a1a";

    -- The elements to be formatted
    local elements = {};
    -- How many cells have been formatted
    local num_cells = 0;

    -- Translate a cell into elements
    function push(text, is_last)
        local cell_no = num_cells + 1
        table.insert(elements, { Foreground = { Color = colors[cell_no] } })
        table.insert(elements, { Text = SOLID_LEFT_ARROW })
        table.insert(elements, { Foreground = { Color = text_fg } })
        table.insert(elements, { Background = { Color = colors[cell_no] } })
        table.insert(elements, { Text = " " .. text .. " " })
        num_cells = num_cells + 1
    end

    while #cells > 0 do
        local cell = table.remove(cells, #cells)
        push(cell, #cells == 0)
    end

    window:set_right_status(wezterm.format(elements))
end)

return {
    color_scheme = 'Catppuccin Frappe',
    max_fps = 100,
    status_update_interval = 500,
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
                -- The green is matching my windows manager borders
                fg_color = '#1a1a1a',
                bg_color = '#00ff00',
                intensity = 'Bold',
            },
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
