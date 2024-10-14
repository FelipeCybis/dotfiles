return {
    'xvzc/chezmoi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'ibhagwan/fzf-lua' },
    config = function()
        require("chezmoi").setup {
            -- your configurations
            edit = {
                watch = false,
                force = false,
            },
            notification = {
                on_open = true,
                on_apply = true,
                on_watch = false,
            },
            --  e.g. ~/.local/share/chezmoi/*
            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                pattern = { os.getenv("HOME") or os.getenv("USERPROFILE") .. "/.local/share/chezmoi/*" },
                callback = function(ev)
                    local bufnr = ev.buf
                    local edit_watch = function()
                        require("chezmoi.commands.__edit").watch(bufnr)
                    end
                    vim.schedule(edit_watch)
                end,
            }),
        }

        local Path = require("plenary.path")
        local fzf_lua = require("fzf-lua")
        Chezmoi_files = function()
            local full_list = require("chezmoi.commands").list()
            local files = {}
            for _, filename in ipairs(full_list) do
                local path = Path:new("~/" .. filename)
                if not Path:new(path:expand()):is_dir() then
                    table.insert(files, "~/" .. filename)
                end
            end
            return files
        end
        Fzf_Chezmoi = function()
            fzf_lua.fzf_exec(Chezmoi_files(), {
                prompt    = "Chezmoi Files> ",
                previewer = "builtin",
                actions   = {
                    ['default'] = function(selected, opts)
                        require("chezmoi.commands").edit({
                            targets = { selected[1] },
                            args = { "--watch" }
                        })
                    end,
                }
            })
        end

        vim.api.nvim_command('command! ChezmoiFzf lua Fzf_Chezmoi()')
        vim.keymap.set('n', '<leader>fc', '<CMD>ChezmoiFzf<CR>', { desc = "[f]zf: [c]hezmoi" })
    end
}
