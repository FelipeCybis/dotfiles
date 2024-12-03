return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        event = "VeryLazy",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            debug = true,
        },
    },
}
