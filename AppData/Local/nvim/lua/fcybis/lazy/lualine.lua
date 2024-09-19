return {
    "nvim-lualine/lualine.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        require("lualine").setup {
            options = {
                disabled_filetypes = { "packer", "NVimTree" },
            },

        }
        vim.opt.showmode = false
    end,
}
