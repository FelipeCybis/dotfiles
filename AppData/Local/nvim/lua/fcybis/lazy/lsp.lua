return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
    },
    config = function()
      require("fidget").setup({})
      require("mason").setup({ log_level = vim.log.levels.DEBUG })
      require("mason-lspconfig").setup({
        ensure_installed = {
          "basedpyright",
          "lua_ls",
          "ruff",
          "tinymist",
        },
        handlers = {
          lua_ls = function() require("lspconfig").lua_ls.setup({}) end,
          -- Rust analyzer is disbaled here because all work is done by
          -- rustaceanvim (rustacean.lua), but even uninstalled from mason it
          -- would cause some kind of conflicts so this empty function makes sure
          -- it is disabled
          rust_analyzer = function() end,
          ruff = function()
            require("lspconfig").ruff.setup({
              on_attach = function(client, bufnr)
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false

                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.code_action({
                      context = { only = { "source.organizeImports.ruff" } },
                      apply = true,
                    })
                    vim.wait(100)
                  end,
                })
              end
            })
          end,
          basedpyright = function()
            require("lspconfig").basedpyright.setup({
              settings = {
                basedpyright = {
                  -- Using Ruff"s import organizer.
                  disableOrganizeImports = true,
                  analysis = {
                    -- Ignore all files for analysis to exclusively use
                    -- Ruff for linting.
                    -- ignore = { "*" },
                    diagnosticSeverityOverrides = {
                      reportUnusedImport = "none",
                    },
                    -- I use too many packages that don't have stubs.
                    typeCheckingMode = "basic",
                  },
                },
              },
            })
          end,
          tinymist = function()
            require("lspconfig").tinymist.setup({
              single_file_support = true,
              root_dir = function()
                return vim.fn.getcwd()
              end,
              settings = {
                formatterMode = "typstyle",
                preview = {
                  pinPreviewFile = false,
                }
              },
            })
            -- create a nvim command to execute a lsp buf command
            vim.api.nvim_command(
              "command! TinymistpinMain lua vim.lsp.buf.execute_command({ command = 'tinymist.pinMain', arguments = { vim.api.nvim_buf_get_name(0) } })")
          end,
        },
      })

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          local bufnr = args.buf
          local lsp = vim.lsp.buf

          local map = function(mode, lhs, rhs, opts)
            if opts.buffer == nil then
              opts.buffer = bufnr
            end
            vim.keymap.set(mode, lhs, rhs, opts)
          end
          map('n', 'gy', function() lsp.type_definition() end, { desc = "LSP: [g]oto t[y]pe def" })
          map('n', 'gd', function() lsp.definition() end, { desc = "LSP: [g]oto [d]efinition" })
          map('n', 'gs', function() lsp.signature_help() end, { desc = "LSP: [g]oto [s]ignature" })

          map("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "[c]ode: [a]ctions" })
          map("n", "gr", "<cmd>FzfLua lsp_references<CR>", { desc = "LSP: [g]oto [r]eferences" })
          map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "[l]SP: [d]efinitions" })
          map("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "[l]SP [s]ymbols" })
          map("n", "<leader>lx", "<cmd>FzfLua lsp_document_diagnostics<CR>", { desc = "[l]SP diagnostic[x]" })
          -- Other mappings to be used by any LSP
          map("n", "<leader>lf", function() lsp.format({ async = true }) end,
            { desc = "[l]SP: [f]ormat buffer" })
          -- Toggle inlay hints
          map("n", "<leader>li", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
          end, { desc = "[l]SP: [i]nlay hints" })

          if client.supports_method("textDocument/formatting") then
            -- Format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                lsp.format({ bufnr = bufnr, id = client.id })
              end,
            })
          end
        end,
      })
    end,
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
    version = 'v0.*',

    opts = {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<C-y>'] = { 'accept', 'fallback' },

        ['<Up>'] = { 'snippet_forward', 'fallback' },
        ['<Down>'] = { 'snippet_backward', 'fallback' },

        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
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
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }
  },
}
