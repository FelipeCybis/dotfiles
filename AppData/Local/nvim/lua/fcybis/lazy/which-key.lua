return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>a", group = "[a]i sidekick", icon = { icon = "", color = "green" } },
        { "<leader>b", group = "[b]uffer", icon = { icon = "󰃧 ", color = "cyan" } },
        { "<leader>c", group = "[c]ode", icon = { icon = " ", color = "cyan" } },
        { "<leader>d", group = "[d]ebug", icon = { icon = " ", color = "cyan" } },
        { "<leader>dp", group = "profiler" },
        { "<leader>e", group = "[e]xplorer", icon = { icon = " ", color = "yellow" } },
        { "<leader>f", group = "[f]ind", icon = { icon = "󰮗 ", color = "yellow" } },
        { "<leader>g", group = "[g]it", icon = { icon = " ", color = "red" } },
        { "<leader>gc", group = "[g]it [c]ommit", icon = { icon = " ", color = "red" } },
        { "<leader>gh", group = "[g]it[h]ub" },
        { "<leader>i", group = "[i]iron", icon = { icon = " ", color = "yellow" } },
        { "<leader>l", group = "[l]sp", icon = { icon = "😛 ", color = "orange" } },
        { "<leader>q", group = "quit/session" },
        { "<leader>r", group = "[r]eplace", icon = { icon = " ", color = "orange" } },
        { "<leader>rw", group = "[r]eplace [w]ord", icon = { icon = " ", color = "orange" } },
        { "<leader>s", group = "[s]earch", icon = { icon = "󰮗 ", color = "orange" } },
        { "<leader>t", group = "[t]erminal", icon = { icon = " ", color = "red" } },
        { "<leader>u", group = "[u]ntoggle/toggle", icon = { icon = " ", color = "red" } },
        { "<leader>x", group = "diagnostic[x]/quickfi[x]", icon = { icon = "󱖫 ", color = "red" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "[g]oto" },
        { "gs", group = "[s]urround" },
        { "gr", group = "[r]rr lsp" },
        { "gri", desc = "LSP: [i]mplementations" },
        { "gra", desc = "LSP: code [a]ction" },
        { "grn", desc = "LSP: [r]ename" },
        { "grt", desc = "LSP: [t]ype definition" },
        { "z", group = "fold" },
      },
    }
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
