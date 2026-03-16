return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "personal",
        path = function()
          if vim.fn.has("wsl") == 1 then
            local handle = io.popen("wslpath \"$(wslvar USERPROFILE)\"")
            local win_home = handle:read("*a"):gsub("%s+$", "")
            handle:close()
            return win_home .. "/Notes"
          end
          return "~/Notes"
        end
      },
    },
  },
}
