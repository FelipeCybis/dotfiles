return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  lazy = true,
  keys = {
    {
      "<leader>hl",
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      desc = "[H]arpoon: quick [l]ist",
    },

    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
      desc = "[H]arpoon: [a]dd",
    },

    {
      "<C-h>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon: select buffer 1"
    },

    {
      "<C-j>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon: select buffer 2"
    },

    {
      "<C-k>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon: select buffer 3"
    },

    {
      "<C-l>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon: select buffer 4"
    },
  },
}
