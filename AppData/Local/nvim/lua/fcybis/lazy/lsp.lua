return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "j-hui/fidget.nvim",
        },

        config = function()
            local lsp_zero = require("lsp-zero")

            lsp_zero.on_attach(function(client, bufnr)
                -- Keep default lsp_zero mappings
                lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
                -- Fzf-improved lsp commands
                vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>",
                    { buffer = bufnr, desc = "LSP [g]oto [r]eferences" })
                vim.keymap.set("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>",
                    { buffer = bufnr, desc = "[L]SP [d]efinitions" })
                vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>",
                    { buffer = bufnr, desc = "[C]ode [a]ctions" })
                vim.keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>",
                    { buffer = bufnr, desc = "[L]SP [s]ymbols" })
                vim.keymap.set("n", "<leader>lx", "<cmd>FzfLua lsp_document_diagnostics<CR>",
                    { buffer = bufnr, desc = "[L]SP diagnostic[x]" })
                -- Other mappings to be used by any LSP
                vim.keymap.set("n", "<leader>lf", function()
                    vim.lsp.buf.format()
                end, { buffer = bufnr, desc = "[L]SP [f]ormat buffer" })
                -- Toggle inlay hints
                vim.keymap.set("n", "<leader>li", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
                end, { buffer = bufnr, desc = "[L]SP [i]nlay hints" })
            end)

            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ["ruff"] = { "python" },
                    ["lua_ls"] = { "lua" },
                    ["tinymist"] = { "typst" },
                }
            })

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
                    lsp_zero.default_setup,
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
                                    typeCheckingMode = "off",
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
                            },
                        })
                    end,
                },
            })

            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "nvim_lsp", group_index = 1 },
                    { name = "path",     group_index = 1 },
                    { name = "buffer",   group_index = 2 },
                },
                mapping = {
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = "select" }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path", group_index = 1 },
                    {
                        name = "cmdline",
                        option = { ignore_cmds = { "Man", "!" } },
                        group_index = 2
                    }
                }
            })
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    {                                        -- optional cmp completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            })
        end,
    },
}
