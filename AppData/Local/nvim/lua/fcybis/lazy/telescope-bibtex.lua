return {
  -- "nvim-telescope/telescope-bibtex.nvim",
  "FelipeCybis/telescope-bibtex.nvim",
  branch = "fix-context-pandoc",
  enabled = false,

  dependencies = { "nvim-telescope/telescope.nvim" },

  config = function()
    require("telescope").setup({
      extensions = {
        bibtex = {
          context = true,
          context_fallback = true,
        },
      },
    })
    require("telescope").load_extension("bibtex")
  end,

  keys = {
    { mode = { "i", "n" }, "<c-b>", "<CMD>Telescope bibtex<CR>" },
  }
}
