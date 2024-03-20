
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
end

return options
