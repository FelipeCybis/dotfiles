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
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
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
    local fzf_files_local = function()
      fzf.files({ cwd = vim.fn.expand('%:h') })
    end

    return {
      -- find
      -- { "<leader>fb", fzf.buffers,          desc = "[f]ind: [b]uffers" },
      { "<leader>fd", fzf_files_local,      desc = "[f]ind: files from current [d]irectory" },
      -- { "<leader>ff", fzf.files,            desc = "[f]ind: [f]iles" },
      { "<leader>fo", fzf.oldfiles,         desc = "[f]ind: [o]ld files" },
      { "<leader>fp", fzf.complete_file,    desc = "[f]ind: complete file [p]ath" },
      { "<leader>fq", fzf.quickfix,         desc = "[f]ind: [q]uickfix" },
      { "<leader>fQ", fzf.quickfix_stack,   desc = "[f]ind: [Q]uickfix stack" },
      { "<leader>fs", fzf.spell_suggest,    desc = "[f]ind: [s]pell suggestion" },
      { "<leader>ft", fzf.tabs,             desc = "[f]ind: [t]abs" },
      { "<leader>fz", fzf.builtin,          desc = "[f]ind: f[z]f" },
      { "<leader>fZ", fzf.zoxide,           desc = "[f]ind: [Z]oxide" },
      -- search
      { "<leader>sc", fzf.command_history,  desc = "[s]earch: [c]ommand history" },
      { "<leader>sg", fzf.live_grep_native, desc = "[s]earch: [g]rep" },
      { "<leader>sh", fzf.helptags,         desc = "[s]earch: [h]elp" },
      { "<leader>sq", fzf.lgrep_quickfix,   desc = "[s]earch: [q]uickfix" },
      { "<leader>sw", fzf.grep_cword,       desc = "[s]earch: grep [w]ord under cursor" },
      { "<leader>sv", fzf.grep_visual,      desc = "[s]earch: grep [v]isual selection" },
      { "<leader>s/", fzf.search_history,   desc = "[s]earch: [/]history" },
      -- Git fzf stuff
      { "<leader>gb", fzf.git_bcommits,     desc = "[g]it: commits ([b]uffer)" },
      { "<leader>gc", fzf.git_commits,      desc = "[g]it: [c]ommits (project)" },
      { "<leader>gB", fzf.git_branches,     desc = "[g]it: [B]ranches" },
      { "<leader>gS", fzf.git_stash,        desc = "[g]it: [S]tash" },
      { "<leader>gs", fzf.git_status,       desc = "[g]it: [s]tatus" },
      { "<leader>gt", fzf.git_tags,         desc = "[g]it: [t]ags" },
    }
  end,
}
