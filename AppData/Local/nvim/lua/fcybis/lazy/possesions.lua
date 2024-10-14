return {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
        "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local ses_dir = require("plenary.path"):new(vim.fn.stdpath("data") .. "/sessions/")
        ses_dir:mkdir()
        require("nvim-possession").setup({
            fzf_winopts = {
                -- any valid fzf-lua winopts options, for instance
                width = 0.7,
            }
        })
    end,
    init = function()
        local possession = require("nvim-possession")
        vim.keymap.set("n", "<leader>sl", function()
            possession.list()
        end, { desc = "[s]essions: [l]ist" })
        vim.keymap.set("n", "<leader>sn", function()
            possession.new()
        end, { desc = "[s]essions: [n]ew" })
        vim.keymap.set("n", "<leader>su", function()
            possession.update()
        end, { desc = "[s]essions: [u]pdate" })
        vim.keymap.set("n", "<leader>sd", function()
            possession.delete()
        end, { desc = "[s]essions: [d]elete" })
    end,
}
