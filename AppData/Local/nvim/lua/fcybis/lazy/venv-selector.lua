return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  event = "VeryLazy",
  branch = "main",
  opts = {
    settings = {
      search = {
        hatch = false,
        poetry = false,
        pyenv = false,
        pipenv = false,
        anaconda_envs = false,
        anaconda_base = false,
        miniconda_envs = false,
        miniconda_base = false,
        pipx = false,
      }
    }
  },
  keys = {
    { "<leader>vv", "<cmd>VenvSelect<cr>", desc = "Python [v]en[v] selector" },
  },
}
