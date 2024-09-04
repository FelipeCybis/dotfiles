local platform = require('utils.platform')()

local options = {
    default_prog = {},
    launch_menu = {},
}

if platform.is_win then
    options.default_prog = { 'pwsh' }
    options.launch_menu = {
        { label = 'PowerShell Core', args = { 'pwsh' } },
        {
            label = 'WSL:Ubuntu',
            domain = { DomainName = 'WSL:Ubuntu' },
        },
        {
            label = 'WSL:Ubuntu - monitoring',
            domain = { DomainName = 'WSL:Ubuntu' },
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
