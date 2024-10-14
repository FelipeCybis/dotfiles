local platform = require('utils.platform')()

local options = {
    default_prog = {},
    launch_menu = {},
    default_gui_startup_args = {},
}

if platform.is_win then
    options.default_prog = { 'pwsh' }
    options.default_gui_startup_args = { 'connect', 'mux' }
    options.launch_menu = {
        { label = 'PowerShell Core', args = { 'pwsh' } },
        {
            label = 'WSL:Ubuntu',
            domain = { DomainName = 'WSL:Ubuntu' },
        },
        {
            label = 'Monitoring',
            domain = { DomainName = 'monitoring' },
        },
    }
elseif platform.is_mac then
    options.default_prog = { 'zsh' }
    options.launch_menu = {
        { label = 'Zsh',  args = { 'zsh' } },
        { label = 'Bash', args = { 'bash' } },
    }
end

return options
