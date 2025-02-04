return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>b", group = "[b]uffer", icon = { icon = "󰃧 ", color = "cyan" } },
        { "<leader>c", group = "[c]ode", icon = { icon = " ", color = "cyan" } },
        { "<leader>d", group = "[d]ebug", icon = { icon = " ", color = "cyan" } },
        { "<leader>dp", group = "profiler" },
        { "<leader>e", group = "[e]xplorer", icon = { icon = " ", color = "yellow" } },
        { "<leader>f", group = "[f]ind", icon = { icon = "󰮗 ", color = "yellow" } },
        { "<leader>g", group = "[g]it", icon = { icon = " ", color = "red" } },
        { "<leader>gh", group = "hunks" },
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
        { "z", group = "fold" },
      },
    }
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
