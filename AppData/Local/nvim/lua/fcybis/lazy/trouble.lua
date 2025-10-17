return {
  "folke/trouble.nvim",

  opts = {},

  cmd = "Trouble",

  keys = function()
    local trouble = require("trouble")
    local move_and_jump = function(trouble_fun)
      return function()
        local opts = { mode = trouble.last_mode or "symbols", focus = false }
        trouble_fun(opts)
        ---@diagnostic disable-next-line
        trouble.jump()
      end
    end
    return {
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
        ---@diagnostic disable-next-line
        function() trouble.toggle({ mode = "symbols", focus = false }) end,
        desc = "[c]ode: Trouble [s]ymbols",
      },
      {
        "<C-]>",
        move_and_jump(trouble.next),
        desc = "Next Trouble item",
      },
      {
        "]g",
        move_and_jump(trouble.last),
        desc = "[g]oto: last Trouble item",
      },
      {
        "<C-[>",
        move_and_jump(trouble.prev),
        desc = "Previous Trouble item",
      },
      {
        "[g",
        move_and_jump(trouble.first),
        desc = "[g]oto: first Trouble item",
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
