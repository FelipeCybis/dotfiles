return {
  'xvzc/chezmoi.nvim',
  event = 'VeryLazy',
  config = function()
    local chezmoi_pattern = os.getenv("HOME") or os.getenv("USERPROFILE") or "~"
    chezmoi_pattern = chezmoi_pattern:gsub("\\", "/") .. "/.local/share/chezmoi/*"
    require("chezmoi").setup {
      -- your configurations
      edit = {
        watch = true,
        force = false,
      },
    }
  end,
  keys = function()
    local Path = require("plenary.path")
    local fzf_lua = require("fzf-lua")
    Chezmoi_files = function()
      local full_list = require("chezmoi.commands").list()
      local files = {}
      for _, filename in ipairs(full_list) do
        local path = Path:new("~/" .. filename)
        if not Path:new(path:expand()):is_dir() then
          table.insert(files, "~/" .. filename)
        end
      end
      return files
    end

    Rg_Chezmoi = function()
      ---@diagnostic disable-next-line: missing-fields
      fzf_lua.fzf_live("rg --column --line-number --color=always --smart-case", {
        prompt = "Chezmoi Grep> ",
        cwd = "~/.local/share/chezmoi",
        actions = fzf_lua.defaults.actions.files,
      })
    end

    vim.keymap.set('n', '<leader>cz', function() require("chezmoi.pick").telescope() end)
    local Snacks = require("snacks")
    local chezmoi_dir = Path:new("~/.local/share/chezmoi"):expand()
    local lazygit_args = { args = { "--path", chezmoi_dir } }
    return {
      { '<leader>fc', function() require("chezmoi.pick").snacks() end,  desc = '[f]ind: [c]hezmoi files' },
      { '<leader>sC', Rg_Chezmoi,                                       desc = '[s]earch: grep [C]hezmoi' },
      { '<leader>lc', function() Snacks.lazygit.open(lazygit_args) end, desc = '[l]azygit: [c]hezmoi' },
    }
  end,
}
