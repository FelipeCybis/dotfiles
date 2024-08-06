return {
    "mbbill/undotree",

    config = function()
        vim.g.undotree_DiffCommand = "FC"
    end,

    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" }
    },
}
