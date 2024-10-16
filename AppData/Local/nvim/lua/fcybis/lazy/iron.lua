return {
    "Vigemus/iron.nvim",

    config = function()
        local iron = require("iron.core")

        iron.setup {
            config = {
                scratch_repl = true,

                repl_definition = {
                    sh = {
                        command = { "pwsh" },
                    },
                    python = {
                        command = { "ipython", "--no-autoindent" },
                        format = require("iron.fts.common").bracketed_paste_python,
                    },
                },
                repl_open_cmd = require("iron.view").split.belowright("20%"),
            },

            keymaps = {
                send_motion = "<leader>is",
                visual_send = "<leader>is",
                send_file = "<leader>if",
                send_line = "<leader>ii",
                send_paragraph = "<leader>ip",
                send_until_cursor = "<leader>iu",
                send_mark = "<leader>iS",
                mark_motion = "<leader>im",
                mark_visual = "<leader>im",
                remove_mark = "<leader>md",
                cr = "<leader>i<cr>",
                interrupt = "<leader>ic",
                exit = "<leader>iq",
                clear = "<leader>il",
            },
            highlight = {
                italic = true
            },
            ignore_blank_lines = true,
        }
    end,
    keys = {
        { "<leader>iR", "<cmd>IronRestart<cr>", desc = "[i]ron: [R]estart REPL" },
        { "<leader>ir", "<cmd>IronFocus<cr>",   desc = "[i]ron: focus [r]EPL" },
        { "<leader>ih", "<cmd>IronHide<cr>",    desc = "[i]ron: [h]ide REPL" },
    }
}
