return {
    'xvzc/chezmoi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
            telescope = {
                select = { "<CR>" },
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
        _fzf_chezmoi = function()
            require 'fzf-lua'.fzf_exec(require("chezmoi.commands").list(), {
                actions = {
                    ['default'] = function(selected, opts)
                        require("chezmoi.commands").edit({
                            targets = { "~/" .. selected[1] },
                            args = { "--watch" }
                        })
                    end
                }
            })
        end

        vim.api.nvim_command('command! ChezmoiFzf lua _fzf_chezmoi()')
    end
}
