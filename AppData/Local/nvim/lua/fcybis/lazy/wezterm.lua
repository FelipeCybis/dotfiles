return {
    "willothy/wezterm.nvim",
    config = function()
        local wezterm = require("wezterm")
        wezterm.set_user_var("NVIM_WEZTERM", true)
        vim.api.nvim_create_autocmd("ExitPre", {
            callback = function() wezterm.set_user_var("NVIM_WEZTERM", false) end, -- the function to call
        })
    end,
}
