return {
    "mbbill/undotree",

    config = function()
        vim.g.undotree_DiffCommand = "FC"
    end,

    keys = {
        { "<leader>tu", vim.cmd.UndotreeToggle, desc = "[t]oggle [u]ndotree" }
    },
}
