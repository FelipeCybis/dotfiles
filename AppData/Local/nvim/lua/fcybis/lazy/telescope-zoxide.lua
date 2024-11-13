return {
    "jvgrootveld/telescope-zoxide",
    config = function()
        require("telescope").load_extension("zoxide")
    end,
    keys = {
        { mode = { "n" }, "<leader>zo", "<CMD>Telescope zoxide list<CR>" },
    }

}
