return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
    end,

    keys = function()
        local fzf = require("fzf-lua")

        return {
            { "<leader>fz",  fzf.builtin,          desc = "Self Fzf" },
            { "<leader>ff",  fzf.files,            desc = "Fzf: files" },
            { "<leader>fo",  fzf.oldfiles,         desc = "Fzf: old files" },
            { "<leader>fg",  fzf.live_grep_native, desc = "Fzf: grep" },
            { "<leader>fb",  fzf.buffers,          desc = "Fzf: buffers" },
            { "<leader>fh",  fzf.helptags,         desc = "Fzf: help" },
            { "<leader>/",   fzf.blines,           desc = "Fzf: fzf current buffer" },
            -- Git fzf stuff
            { "<leader>gb",  fzf.git_branches,     desc = "Fzf: Git branches" },
            { "<leader>gs",  fzf.git_status,       desc = "Fzf: Git status" },
            { "<leader>gt",  fzf.git_stash,        desc = "Fzf: Git stash" },
            { "<leader>gc",  fzf.git_commits,      desc = "Fzf: Git commits (project)" },
            { "<leader>gcb", fzf.git_bcommits,     desc = "Fzf: Git commits (buffer)" },
            -- go to nvim config cwd and search files there
            {
                "<leader>vrc",
                function()
                    fzf.files({
                        cwd = vim.fn.stdpath('config')
                    })
                end,
                desc = "Fzf: nvim config"
            },
        }
    end,
}
