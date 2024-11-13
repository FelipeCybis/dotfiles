return {
    "ThePrimeagen/harpoon",

    branch = "harpoon2",

    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

    opts = {},

    keys = function()
        local harpoon = require("harpoon")
        return {
            {
                "<leader>hl",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "[H]arpoon: quick [l]ist",
            },

            {
                "<leader>ha",
                function()
                    harpoon:list():add()
                end,
                desc = "[H]arpoon: [a]dd",
            },

            {
                "<C-h>",
                function()
                    harpoon:list():select(1)
                end,
                desc = "Harpoon: select buffer 1"
            },

            {
                "<C-j>",
                function()
                    harpoon:list():select(2)
                end,
                desc = "Harpoon: select buffer 2"
            },

            {
                "<C-k>",
                function()
                    harpoon:list():select(3)
                end,
                desc = "Harpoon: select buffer 3"
            },

            {
                "<C-l>",
                function()
                    harpoon:list():select(4)
                end,
                desc = "Harpoon: select buffer 4"
            },
            -- Toggle previous & next buffers stored within Harpoon list
            {
                "<C-p>",
                function()
                    harpoon:list():prev()
                end,
                desc = "Harpoon: previous",
            },

            {
                "<C-n>",
                function()
                    harpoon:list():next()
                end,
                desc = "Harpoon: next",
            },
        }
    end,
}
