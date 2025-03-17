return {
  -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
  ssh_domains = {
    {
      name = "labo",
      remote_address = "10.113.113.60",
      username = "Felipe",

    }
  },

  -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
  unix_domains = {
    {
      name = "mux",
    },
  },

  -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
  wsl_domains = {
    {
      name = 'WSL:Ubuntu',
      distribution = 'Ubuntu',
      username = 'fpereir',
      default_cwd = '/home/fpereir',
    },
  },
}
