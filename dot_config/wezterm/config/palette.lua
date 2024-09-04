local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

wezterm.on('augment-command-palette', function(window, pane)
    return {
        {
            brief = 'CUSTOM | Attach to labo in current pane',
            icon = 'md_lan_connect',
            action = wezterm.action.AttachDomain 'labo'
        },
        {
            brief = 'CUSTOM | Attach to monitoring in current pane',
            icon = 'md_lan_connect',
            action = wezterm.action.AttachDomain 'monitoring'
        },
    }
end)

return config
