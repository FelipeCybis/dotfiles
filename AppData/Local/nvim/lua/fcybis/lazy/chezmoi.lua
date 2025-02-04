return {
  'xvzc/chezmoi.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim', 'ibhagwan/fzf-lua' },
  config = function()
    local Path = require("plenary.path")
    local chezmoi_pattern = os.getenv("HOME") or os.getenv("USERPROFILE") or "~"
    chezmoi_pattern = chezmoi_pattern:gsub("\\", "/") .. "/.local/share/chezmoi/*"
    require("chezmoi").setup {
      -- your configurations
      edit = {
        watch = true,
        force = false,
      },
      notification = {
        on_open = true,
        on_apply = true,
        on_watch = true,
      },
      --  e.g. ~/.local/share/chezmoi/*:
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = chezmoi_pattern,
        callback = function(ev)
          local bufnr = ev.buf
          local edit_watch = function()
            require("chezmoi.commands.__edit").watch(bufnr)
          end
          vim.schedule(edit_watch)
        end,
      }),
    }

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
    Fzf_Chezmoi = function()
      fzf_lua.fzf_exec(Chezmoi_files(), {
        prompt    = "Chezmoi Files> ",
        previewer = "builtin",
        actions   = {
          ['default'] = function(selected, opts)
            require("chezmoi.commands").edit({
              targets = { selected[1] },
              args = { "--watch" }
            })
          end,
        }
      })
    end

    Rg_Chezmoi = function()
      fzf_lua.fzf_live("rg --column --line-number --color=always --smart-case", {
        prompt = "Chezmoi Grep> ",
        cwd = "~/.local/share/chezmoi",
        actions = fzf_lua.defaults.actions.files,
      })
    end

    vim.api.nvim_command('command! ChezmoiFzf lua Fzf_Chezmoi()')
    vim.keymap.set('n', '<leader>fc', '<CMD>ChezmoiFzf<CR>', { desc = "[f]ind: [c]hezmoi files" })
    vim.api.nvim_command('command! ChezmoiRg lua Rg_Chezmoi()')
    vim.keymap.set('n', '<leader>sC', '<CMD>ChezmoiRg<CR>', { desc = "[s]earch: grep [C]hezmoi" })
  end,
}
