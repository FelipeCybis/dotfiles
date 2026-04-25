return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { lsp = { enabled = true } },
    latex = {
      enabled = true,
      render_modes = false,
      highlight = 'RenderMarkdownMath',
      position = 'center',
      top_pad = 0,
      bottom_pad = 0,
    },
  },
}
