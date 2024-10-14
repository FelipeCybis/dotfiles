return {
    "nvim-lualine/lualine.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        require("lualine").setup {
            options = {
                disabled_filetypes = { "packer", "NVimTree" },
            },
            sections = {
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    }
                },
            },
        }
        vim.opt.showmode = false
    end,
}
