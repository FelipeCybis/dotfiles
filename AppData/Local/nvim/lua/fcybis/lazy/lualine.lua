return {
  "nvim-lualine/lualine.nvim",

  event = "VeryLazy",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("lualine").setup {
      options = {
        disabled_filetypes = { "packer", "NVimTree", "undotree", "starter", "snacks_dashboard" },
      },
      sections = {
        lualine_a = { 'filename', 'mode' },
        lualine_c = {
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_x = {
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" },
          },
          'encoding', 'fileformat', 'filetype',
        },
        lualine_y = {
          { function()
            local venv = os.getenv("VIRTUAL_ENV_PROMPT") or os.getenv("VIRTUAL_ENV") or "NO ENV"
            if #venv > 20 then
              venv = "..." .. string.sub(venv, -20)
            end
            return " " .. venv
          end,
            cond = function() return vim.bo.filetype == "python" end,
          },
          'progress',
        },
      },
    }
    vim.opt.showmode = false
  end,
}
