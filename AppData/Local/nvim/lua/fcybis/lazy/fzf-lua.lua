return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = function(_, opts)
    local config = require("fzf-lua.config")

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    return {
      winopts = {
        width = 0.9,
      },
      ui_select = function(fzf_opts, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
            preview = {
              scrollbar = false,
            },
          },
        }, {
          winopts = {
            width = 0.7,
            row = 0.5,
            height = h,
          },
        })
      end,
    }
  end,
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    vim.ui.select = function(...)
      require("fzf-lua").register_ui_select(opts.ui_select or nil)
      return vim.ui.select(...)
    end
  end,

  keys = function()
    local fzf = require("fzf-lua")

    return {
      -- find
      { "<leader>fq", fzf.quickfix,       desc = "[f]ind: [q]uickfix" },
      { "<leader>fQ", fzf.quickfix_stack, desc = "[f]ind: [Q]uickfix stack" },
      { "<leader>fS", fzf.spell_suggest,  desc = "[f]ind: [S]pell suggestion" },
      { "<leader>ft", fzf.tabs,           desc = "[f]ind: [t]abs" },
      { "<leader>fz", fzf.builtin,        desc = "[f]ind: f[z]f" },
      { "<leader>fZ", fzf.zoxide,         desc = "[f]ind: [Z]oxide" },
      -- search
      { "<leader>sh", fzf.helptags,       desc = "[s]earch: [h]elp" },
      { "<leader>sq", fzf.lgrep_quickfix, desc = "[s]earch: [q]uickfix" },
      -- Git fzf stuff
      { "<leader>gB", fzf.git_branches,   desc = "[g]it: [B]ranches" },
      { "<leader>gS", fzf.git_stash,      desc = "[g]it: [S]tash" },
      { "<leader>gs", fzf.git_status,     desc = "[g]it: [s]tatus" },
      { "<leader>gt", fzf.git_tags,       desc = "[g]it: [t]ags" },
    }
  end,
}
