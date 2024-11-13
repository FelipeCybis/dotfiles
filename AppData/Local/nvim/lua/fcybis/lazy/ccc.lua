return {
    -- Color picker
    {
        "uga-rosa/ccc.nvim",
        lazy = true,
        opts = {
            bar_char = "█",
            point_char = "▍",
            highlighter = {
                auto_enable = false,
            },
        },
        cmd = { "CccConvert", "CccPick", "CccHighlighterToggle" },
    },
}
