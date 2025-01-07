return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = function(_, opts)
        local config = require("fzf-lua.config")

        -- Quickfix
        config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
        config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
        config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
        config.defaults.keymap.fzf["ctrl-x"] = "jump"
        config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
        config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
        config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
        config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

        return {
            winopts = {
                width = 0.9,
            },
            ui_select = function(fzf_opts, items)
                return vim.tbl_deep_extend("force", fzf_opts, {
                    prompt = " ",
                    winopts = {
                        title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
                        title_pos = "center",
                        preview = {
                            scrollbar = false,
                        },
                    },
                }, {
                    winopts = {
                        width = 0.5,
                        -- height is number of items, with a max of 80% screen height
                        height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
                    },
                })
            end,
        }
    end,
    config = function(_, opts)
        require("fzf-lua").setup(opts)
        vim.ui.select = function(...)
            require("fzf-lua").register_ui_select(opts.ui_select or nil)
            return vim.ui.select(...)
        end
    end,

    keys = function()
        local fzf = require("fzf-lua")
        local fzf_files_local = function()
            fzf.files({ cwd = vim.fn.expand('%:h') })
        end

        return {
            { "<leader>fz", fzf.builtin,          desc = "Self [f][z]f" },
            { "<leader>ff", fzf.files,            desc = "[f]zf: [f]iles" },
            { "<leader>fd", fzf_files_local,      desc = "[f]zf: files from current [d]irectory" },
            { "<leader>fo", fzf.oldfiles,         desc = "[f]zf: [o]ld files" },
            { "<leader>fG", fzf.live_grep_native, desc = "[f]zf: [G]rep" },
            { "<leader>fg", fzf.lgrep_curbuf,     desc = "[f]zf: [g]rep current buffer" },
            { "<leader>fb", fzf.buffers,          desc = "[f]zf: [b]uffers" },
            { "<leader>fh", fzf.helptags,         desc = "[f]zf: [h]elp" },
            { "<leader>/",  fzf.blines,           desc = "fzf: fzf current buffer" },
            { "<leader>fq", fzf.quickfix,         desc = "[f]zf: [q]uickfix" },
            { "<leader>fQ", fzf.quickfix_stack,   desc = "[f]zf: [Q]uickfix stack" },
            { "<leader>fw", fzf.grep_cword,       desc = "[f]zf: grep [w]ord under cursor" },
            { "<leader>fs", fzf.spell_suggest,    desc = "[f]zf: [s]pell suggestion" },
            { "<leader>fp", fzf.complete_file,    desc = "[f]zf: complete file [p]ath" },
            -- Git fzf stuff
            { "<leader>gB", fzf.git_branches,     desc = "Fzf: [g]it [B]ranches" },
            { "<leader>gs", fzf.git_status,       desc = "Fzf: [g]it [s]tatus" },
            { "<leader>gt", fzf.git_stash,        desc = "Fzf: [g]it s[t]ash" },
            { "<leader>gc", fzf.git_commits,      desc = "Fzf: [g]it [c]ommits (project)" },
            { "<leader>gb", fzf.git_bcommits,     desc = "Fzf: [g]it commits ([b]uffer)" },
        }
    end,
}
