return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.dashboard.pick("files")' },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.dashboard.pick("live_grep ")' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles ")' },
          { icon = ' ', key = 'c', desc = 'Dotfiles', action = ':lua Fzf_Chezmoi()' },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        header = [[
███████╗ ██████╗██╗   ██╗██████╗ ██╗███████╗
██╔════╝██╔════╝╚██╗ ██╔╝██╔══██╗██║██╔════╝
█████╗  ██║      ╚████╔╝ ██████╔╝██║███████╗
██╔══╝  ██║       ╚██╔╝  ██╔══██╗██║╚════██║
██║     ╚██████╗   ██║   ██████╔╝██║███████║
╚═╝      ╚═════╝   ╚═╝   ╚═════╝ ╚═╝╚══════╝]],
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 4, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 4, padding = 1 },
        { section = 'startup' },
      },
    },
  }
}
