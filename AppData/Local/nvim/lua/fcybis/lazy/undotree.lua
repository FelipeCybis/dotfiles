return {
  "mbbill/undotree",

  config = function()
    -- Set diff command to FC on windows only
    if vim.fn.has("win32") == 1 then
      vim.g.undotree_DiffCommand = "FC"
    end
  end,

  keys = {
    { "<leader>uu", vim.cmd.UndotreeToggle, desc = "([u]n)toggle [u]ndotree" }
  },
}
