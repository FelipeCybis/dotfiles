return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = { "nvim-lua/plenary.nvim" },

    opts = {},

    config = function()
        require("telescope").setup({
            pickers = {
                buffers = {
                    mappings = {
                        i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
                    },
                },
            },
        })
    end,

    keys = function()
        local builtin = require("telescope.builtin")

        return {
            { "<leader>ff", builtin.find_files,                desc = "Telescope: files" },
            { "<leader>fp", builtin.git_files,                 desc = "Telescope: git" },
            { "<leader>fg", builtin.live_grep,                 desc = "Telescope: grep" },
            { "<leader>fb", builtin.buffers,                   desc = "Telescope: buffers" },
            { "<leader>fh", builtin.help_tags,                 desc = "Telescope: help" },
            { "<leader>/",  builtin.current_buffer_fuzzy_find, desc = "Telescope: fzf current buffer" },
            {
                "<leader>vrc",
                function()
                    builtin.find_files({
                        prompt_title = "nvim",
                        cwd = vim.fn.stdpath('config')
                    })
                end,
                desc = "Telescope: nvim config"
            },
        }
    end,
}
