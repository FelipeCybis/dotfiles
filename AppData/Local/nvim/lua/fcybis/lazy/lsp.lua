return {
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
            vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", { buffer = bufnr, desc = "Fzf LSP references" })
            vim.keymap.set("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>",
                { buffer = bufnr, desc = "Fzf LSP definitions" })
            vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>",
                { buffer = bufnr, desc = "Code actions" })
            vim.keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>",
                { buffer = bufnr, desc = "Fzf LSP symbols" })
            vim.keymap.set("n", "<leader>lx", "<cmd>FzfLua lsp_document_diagnostics<CR>",
                { buffer = bufnr, desc = "Fzf LSP diagnostics" })
            -- Other mappings to be used by any LSP
            vim.keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format()
            end, { buffer = bufnr, desc = "Format buffer with LSP" })
        end)

        lsp_zero.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["ruff_lsp"] = { "python" },
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
                "ruff_lsp",
                "tinymist",
            },
            handlers = {
                lsp_zero.default_setup,
                -- Rust analyzer is disbaled here because all work is done by
                -- rustaceanvim (rustacean.lua), but even uninstalled from mason it
                -- would cause some kind of conflicts so this empty function makes sure
                -- it is disabled
                rust_analyzer = function() end,
                ruff_lsp = function()
                    require("lspconfig").ruff_lsp.setup {
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
                    }
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
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
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
}
