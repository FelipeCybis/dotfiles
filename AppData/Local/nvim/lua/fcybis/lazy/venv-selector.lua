return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
        require("venv-selector").setup({
            settings = {
                search = {
                    hatch = false,
                    poetry = false,
                    pyenv = false,
                    pipenv = false,
                    anaconda_envs = false,
                    anaconda_base = false,
                    miniconda_envs = false,
                    miniconda_base = false,
                    pipx = false,
                }
            }
        })
    end,
    keys = {
        { "<leader>vv", "<cmd>VenvSelect<cr>", desc = "Python [v]en[v] selector" },
    },
}
