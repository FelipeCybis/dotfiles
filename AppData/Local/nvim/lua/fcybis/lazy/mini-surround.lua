return {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    config = {
        mappings = {
            add = "<leader>sa",       -- Add surroundng in Normal and Visual modes
            delete = "<leader>sd",    -- Delete surrounding
            find = "<leader>sf",      -- Find surrounding (to the right)
            find_left = "<leader>sF", -- Find surrounding (to the left)
            highlight = "<leader>sh", -- Highlight surrounding
            replace = "<leader>sr",   -- Replace surrounding
        },
        n_lines = 100,
    },
}
