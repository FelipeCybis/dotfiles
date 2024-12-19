return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
        require("catppuccin").setup({
            integrations = { harpoon = true, mason = true, which_key = true, blink_cmp = true },
        })
        vim.cmd('colorscheme catppuccin-frappe')
    end
}
