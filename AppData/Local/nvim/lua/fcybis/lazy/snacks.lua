return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                header = [[
███████╗ ██████╗██╗   ██╗██████╗ ██╗███████╗
██╔════╝██╔════╝╚██╗ ██╔╝██╔══██╗██║██╔════╝
█████╗  ██║      ╚████╔╝ ██████╔╝██║███████╗
██╔══╝  ██║       ╚██╔╝  ██╔══██╗██║╚════██║
██║     ╚██████╗   ██║   ██████╔╝██║███████║
╚═╝      ╚═════╝   ╚═╝   ╚═════╝ ╚═╝╚══════╝]],
            },
            sections = {
                { section = "header" },
                -- {
                --     pane = 2,
                --     section = "terminal",
                --     cmd = "colorscript -e square",
                --     height = 5,
                --     padding = 1,
                -- },
                { section = "keys", gap = 1, padding = 1 },
                { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 4, padding = 1 },
                { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 4, padding = 1 },
                -- {
                --     pane = 2,
                --     icon = " ",
                --     title = "Git Status",
                --     section = "terminal",
                --     enabled = vim.fn.isdirectory(".git") == 1,
                --     cmd = "git status --short --branch",
                --     height = 5,
                --     padding = 1,
                --     ttl = 5 * 60,
                --     indent = 4,
                -- },
                { section = "startup" },
            },
        },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
            notification = {
                wo = { wrap = true }, -- Wrap notifications
            },
        },
    },
    keys = function()
        -- requiring Snacks here only to have lsp info available
        local Snacks = require('snacks')
        return {
            { '<leader>dn', function() Snacks.notifier.hide() end,      desc = '[d]ismiss [n]otifications' },
            { '<leader>bd', function() Snacks.bufdelete() end,          desc = '[b]uffer [d]elete' },
            { '<leader>lg', function() Snacks.lazygit() end,            desc = '[L]azy[g]it' },
            { '<leader>gl', function() Snacks.git.blame_line() end,     desc = '[g]it blame [l]ine' },
            { '<leader>gr', function() Snacks.gitbrowse() end,          desc = '[g]it [r]emote url' },
            { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
            { '<leader>ts', function() Snacks.terminal() end,           desc = '[t]erminal [s]plit' },
            {
                '<leader>tt',
                function()
                    local cmd = 'zsh'
                    if vim.fn.has('win32') == 1 then
                        cmd = 'pwsh'
                    end
                    Snacks.terminal.toggle(cmd)
                end,
                desc = '[t]oggle [t]erminal floating',
            },
            { ']]',         function() Snacks.words.jump(vim.v.count1) end,  desc = 'Next Reference (snacks)' },
            { '[[',         function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference (snacks)' },
            { '<leader>NH', function() Snacks.notifier.show_history() end,   desc = '[N]otifier [H]istory' },
            {
                '<leader>NN',
                desc = '[N]eovim [N]ews',
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = 'yes',
                            statuscolumn = ' ',
                            conceallevel = 3,
                        },
                    })
                end,
            },
        }
    end,
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
                Snacks.toggle.diagnostics():map('<leader>ud')
                Snacks.toggle.line_number():map('<leader>ul')
                Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map('<leader>uc')
                Snacks.toggle.treesitter():map('<leader>uT')
                Snacks.toggle.inlay_hints():map('<leader>uh')
            end,
        })
    end,
}
