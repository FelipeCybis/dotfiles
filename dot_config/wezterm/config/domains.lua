return {
    -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
    ssh_domains = {},

    -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
    unix_domains = {
        {
            name = 'unix',
        }
    },

    -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
    wsl_domains = {
        {
            name = 'WSL:Ubuntu',
            distribution = 'Ubuntu',
            username = 'fpereir',
            default_cwd = '/home/fpereir',
            default_prog = { 'zsh' },
        },
    },
}
