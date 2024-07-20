local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)
lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ["rust_analyzer"] = { "rust" },
        ["ruff_lsp"] = { "python" },
        ["lua_ls"] = { "lua" },
    }
})

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here 
	-- with the ones you want to install
	ensure_installed = {'rust_analyzer', 'lua_ls', 'pyright', 'ruff_lsp'},
	handlers = {
        lsp_zero.default_setup,
        ruff = function()
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
        pyright = function()
            require("lspconfig").pyright.setup({
                settings = {
                    pyright = {
                        -- Using Ruff"s import organizer.
                        disableOrganizeImports = true,
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
		-- function(server_name)
		-- 	require('lspconfig')[server_name].setup({})
		-- end,
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
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
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

