return {
  "folke/trouble.nvim",

  opts = {},

  cmd = "Trouble",

  keys = function()
    local trouble = require("trouble")
    local move_and_jump = function(trouble_fun)
      return function()
        if not trouble.last_mode then
          return
        end
        local opts = { mode = trouble.last_mode, focus = false, jump = true }
        trouble_fun(opts)
      end
    end
    return {
      {
        "<leader>cq",
        function()
          if trouble.last_mode then
            ---@diagnostic disable-next-line
            trouble.close({ mode = trouble.last_mode })
          end
        end,
        desc = "[c]ode: [q]uit last Trouble view",
      },
      {
        "<leader>cx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "[c]ode: Trouble Diagnostic[x]",
      },
      {
        "<leader>cX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "[c]ode: Trouble Buffer Diagnostic[x]s",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle<cr>",
        desc = "[c]ode: Trouble [s]ymbols",
      },
      {
        "<C-]>",
        move_and_jump(trouble.next),
        desc = "Next Trouble item",
      },
      {
        "<C-[>",
        move_and_jump(trouble.prev),
        desc = "Previous Trouble item",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "[c]ode: Trouble [l]SP Definitions / references / ...",
      },
      {
        "<leader>cL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "[c]ode: Trouble [L]ocation List",
      },
      {
        "<leader>cQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "[c]ode: Trouble [Q]uickfix List",
      },
    }
  end,
}
