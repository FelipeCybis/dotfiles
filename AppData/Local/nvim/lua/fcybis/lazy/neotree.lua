return {
    "nvim-neo-tree/neo-tree.nvim",
    -- This disables or enables the plugin
    -- I'm switching over to mini.files (mini-files.lua) because neotree had
    -- some issues for me, when renaming files or directories sometimes they
    -- didn't update so had to be using oil.nvim
    enabled = true,
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        -- I'm using these 2 keyamps already with mini.files, so avoiding conflict
        { "<leader>e", false },
        { "<leader>E", false },
        -- -- I swapped these 2
        -- { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
        -- { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
        -- New mapping for spacebar+r to reveal in NeoTree
        -- New mapping for spacebar+r to reveal in NeoTree with toggle functionality

        -- -- When I press <leader>r I want to show the current file in neo-tree,
        -- -- But if neo-tree is open it, close it, to work like a toggle
        {
            "<leader>n",
            function()
                -- Function to check if NeoTree is open in any window
                local function is_neo_tree_open()
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].filetype == "neo-tree" then
                            return true
                        end
                    end
                    return false
                end
                if is_neo_tree_open() then
                    -- Close NeoTree if it's open
                    vim.cmd("Neotree close")
                else
                    -- Open NeoTree if it's not open
                    vim.cmd("Neotree reveal")
                end
            end,
            desc = "Toggle current file in [N]eoTree",
        },
    },
}
