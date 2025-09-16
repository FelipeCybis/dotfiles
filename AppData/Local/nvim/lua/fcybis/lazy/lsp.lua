return {
  {
    "j-hui/fidget.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = { log_level = vim.log.levels.DEBUG } },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "tinymist",
            "harper_ls",
          },
          automatic_enable = false,
        }
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    dependencies = {
      { 'gonstoll/wezterm-types', lazy = true },
      { "Bilal2453/luvit-meta",   lazy = true }, -- optional `vim.uv` typings
    },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- Load the wezterm types when the `wezterm` module is required
        { path = 'wezterm-types',      mods = { 'wezterm' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "*",
      },
    },
    version = 'v1.*',

    opts = {
      keymap = {
        preset = 'none',
        ['<C-d>'] = { 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<C-y>'] = { 'accept', 'fallback' },

        ['<Up>'] = { 'snippet_forward', 'fallback' },
        ['<Down>'] = { 'snippet_backward', 'fallback' },

        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono'
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          -- dont show LuaLS require statements when lazydev has items
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100, fallbacks = { "lsp" } },
        },
      },
      -- experimental signature help support
      signature = { enabled = true },
      completion = {
        menu = {
          border = "padded",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            treesitter = { "lsp" },
          }
        },
        documentation = {
          auto_show = false,
        },
      }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
  },
}
