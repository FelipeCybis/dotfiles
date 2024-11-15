return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = function()
        Flash = require("flash")
        return {
            { "s",     mode = { "n", "x", "o" }, Flash.jump(),              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, Flash.treesitter(),        desc = "Flash Treesitter" },
            { "r",     mode = "o",               Flash.remote(),            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      Flash.treesitter_search(), desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           Flash.toggle(),            desc = "Toggle Flash Search" },
        }
    end,
}
