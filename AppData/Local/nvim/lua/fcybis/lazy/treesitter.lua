return {
    "nvim-treesitter/nvim-treesitter",

    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,

    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "python", "typescript", "rust", "markdown" },
        sync_install = false,
        auto_install = false,
        indent = { enable = true },
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                node_decremental = '<c-backspace>',
            }
        }
    }
}
