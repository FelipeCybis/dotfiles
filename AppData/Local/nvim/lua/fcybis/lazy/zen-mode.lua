return {
    "folke/zen-mode.nvim",
    dependencies = { "willothy/wezterm.nvim" },
    keys = {
        { "<C-f>", "<CMD>ZenMode<CR>", desc = "Zen Mode" },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        plugins = {
            wezterm = {
                enabled = true,
                font = "+4",
            },
        },
        on_open = function(win)
            require("wezterm").zoom_pane()
        end,
        on_close = function()
            require("wezterm").zoom_pane()
        end,
    }
}
