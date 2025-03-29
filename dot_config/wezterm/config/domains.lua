local wezterm = require('wezterm') --[[@as Wezterm]]

local default_wsl_domains = wezterm.default_wsl_domains()
local wsl_domains = {}
for idx, dom in ipairs(default_wsl_domains) do
  if string.match(dom.name, "^WSL:Ubuntu") then
    dom.default_cwd = "/home/fpereir"
    dom.username = "fpereir"
    table.insert(wsl_domains, dom)
  end
end


return {
  -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
  ssh_domains = {
    {
      name = "labo",
      remote_address = "10.113.113.60",
      username = "Felipe",

    },
    {
      name = "labo_wsl",
      remote_address = "10.113.113.60",
      username = "Felipe",
      multiplexing = "None",
      default_prog = { "wsl.exe", "-d", "ubuntu-22.04", "--cd", "~" },
    }
  },

  -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
  unix_domains = {
    {
      name = "mux",
    },
  },

  -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
  wsl_domains = wsl_domains,
  mux_enable_ssh_agent = false,
}
