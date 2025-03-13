return {
  "nvim-treesitter/nvim-treesitter",

  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  opts = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "python", "typescript", "rust", "markdown" },
    sync_install = false,
    auto_install = false,
    indent = { enable = true },
    highlight = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gvn',
        node_incremental = 'gvn',
        scope_incremental = 'gvs',
        node_decremental = 'gvN',
      }
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
