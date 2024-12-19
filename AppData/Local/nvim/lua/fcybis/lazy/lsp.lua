return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
        },
        config = function()
            -- Add blink.cmp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = require("lspconfig").util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('blink.cmp').get_lsp_capabilities()
            )

            require("fidget").setup({})
            require("mason").setup({})
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
                                    -- I use too many packages that don't have stubs.
                                    typeCheckingMode = "basic",
                                },
                                python = {
                                    analysis = {
                                        -- Ignore all files for analysis to exclusively use
                                        -- Ruff for linting.
                                        ignore = { "*" },
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
                callback = function(event)
                    local bufnr = event.buf

                    ---@return vim.keymap.set.Opts
                    local opts = function(desc)
                        if desc == nil then
                            return { buffer = bufnr }
                        else
                            return { buffer = bufnr, desc = desc }
                        end
                    end

                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts())
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts())
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts())

                    vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts("LSP [g]oto [r]eferences"))
                    vim.keymap.set("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", opts("[L]SP [d]efinitions"))
                    vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>",
                        opts("[C]ode [a]ctions"))
                    vim.keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>",
                        opts("[L]SP [s]ymbols"))
                    vim.keymap.set("n", "<leader>lx", "<cmd>FzfLua lsp_document_diagnostics<CR>",
                        opts("[L]SP diagnostic[x]"))
                    -- Other mappings to be used by any LSP
                    vim.keymap.set("n", "<leader>lf", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts("[L]SP [f]ormat buffer"))
                    -- Toggle inlay hints
                    vim.keymap.set("n", "<leader>li", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
                    end, opts("[L]SP [i]nlay hints"))
                end,
            })
        end,

    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        dependencies = {
            { 'gonstoll/wezterm-types', lazy = true },
        },
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                -- Load the wezterm types when the `wezterm` module is required
                { path = 'wezterm-types',      mods = { 'wezterm' } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {                                        -- optional cmp completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        lazy = true,
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
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
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
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
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = false,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
                -- optionally disable cmdline completions
                -- cmdline = {},
                providers = {
                    -- dont show LuaLS require statements when lazydev has items
                    lsp = { fallback_for = { "lazydev" } },
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                },
            },
            -- experimental signature help support
            signature = { enabled = true },
            completion = {
                menu = {
                    border = "padded",
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1} },
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
