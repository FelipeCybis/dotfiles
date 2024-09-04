return {
    -- "nvim-telescope/telescope-bibtex.nvim",
    dir = "~/Work/Repos/telescope-bibtex.nvim/",

    config = function()
        require("telescope").setup({
            extensions = {
                bibtex = {
                    context = true,
                    context_fallback = true,
                },
            },
        })
        require("telescope").load_extension("bibtex")
    end,

}
