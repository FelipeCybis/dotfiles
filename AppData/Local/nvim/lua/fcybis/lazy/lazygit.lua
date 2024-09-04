return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },

    config = function()
        vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
        vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
        vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
        vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available
        vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

        vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
        vim.g.lazygit_config_file_path = '' -- custom config file path
        -- OR
        vim.g.lazygit_config_file_path = {} -- table of custom config file paths
    end,
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
}
