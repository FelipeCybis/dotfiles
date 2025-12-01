vim.lsp.enable({ "lua_ls", "ty", "ruff", "harper_ls", "tinymist" })

vim.lsp.config("harper_ls", { filetypes = { "typst", "markdown", "gitcommit" } })

vim.lsp.set_log_level("off")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = 'LSP actions on attach',
  callback = function(args)
    local lsp = vim.lsp.buf
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- vim.print("LSP " .. client.name .. " attached to buffer " .. bufnr)

    local map = function(mode, lhs, rhs, opts)
      if type(opts) == "string" then
        opts = { desc = opts }
      end
      if opts.buffer == nil then
        opts.buffer = bufnr
      end
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map('n', 'gy', function() lsp.type_definition() end, "LSP: [g]oto t[y]pe def")
    map('n', 'gd', function() lsp.definition() end, "LSP: [g]oto [d]efinition")
    map('n', 'gs', function() lsp.signature_help() end, "LSP: [g]oto [s]ignature")
    map("n", "gr", "<cmd>FzfLua lsp_references<CR>", "LSP: [g]oto [r]eferences")

    map("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", "[c]ode: [a]ctions")
    map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", "[l]SP: [d]efinitions")
    map("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", "[l]SP [s]ymbols")
    map("n", "<leader>lx", "<cmd>FzfLua lsp_document_diagnostics<CR>", "[l]SP diagnostic[x]")

    -- Other mappings to be used by any LSP
    map("n", "<leader>lf", function() lsp.format({ async = true }) end, "[l]SP: [f]ormat buffer")

    -- Toggle inlay hints
    map("n", "<leader>li", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, "[l]SP: [i]nlay hints")

    -- format on save for any client with formatting
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          -- vim.print("Formatting with " .. client.name .. " ID: " .. client.id)
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end

    if client.name == "tinymist" then
      vim.api.nvim_create_user_command("TypstPin", function()
        client:exec_cmd({
          title = "pin",
          command = "tinymist.pinMain",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }, { bufnr = bufnr }, function(err)
          if err then
            vim.notify("Error pinning: " .. err, vim.log.levels.ERROR)
          else
            vim.notify("Succesfully pinned!", vim.log.levels.INFO)
            vim.g.typst_main_file = vim.api.nvim_buf_get_name(0)
          end
        end)
      end, {})
      map("n", "<leader>lp", "<cmd>TypstPin<CR>", "[l]SP: [p]in main file")
    end
  end,
})
