return {
    -- Color picker
    {
        "uga-rosa/ccc.nvim",
        lazy = false,
        opts = {
            bar_char = "█",
            point_char = "▍",
            highlighter = {
                auto_enable = false,
            },
        },
        config = function(_, opts)
            require("ccc").setup(opts)
        end,
    },
}
