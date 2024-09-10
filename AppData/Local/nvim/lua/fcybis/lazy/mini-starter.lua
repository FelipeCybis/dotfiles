return {
    "echasnovski/mini.starter",
    version = "0.13.0",
    config = function()
        local starter = require("mini.starter")
        local opts = {
            evaluate_single = false,
            header = table.concat({
                "███████╗ ██████╗██╗   ██╗██████╗ ██╗███████╗",
                "██╔════╝██╔════╝╚██╗ ██╔╝██╔══██╗██║██╔════╝",
                "█████╗  ██║      ╚████╔╝ ██████╔╝██║███████╗",
                "██╔══╝  ██║       ╚██╔╝  ██╔══██╗██║╚════██║",
                "██║     ╚██████╗   ██║   ██████╔╝██║███████║",
                "╚═╝      ╚═════╝   ╚═╝   ╚═════╝ ╚═╝╚══════╝",
            }, "\n"),
            footer = os.date(),
            items = {
                starter.sections.builtin_actions(),
                starter.sections.recent_files(10, false),
                starter.sections.recent_files(10, true),
            },
            content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.padding(3, 2),
                starter.gen_hook.aligning('center', 'center'),
            },
        }

        starter.setup(opts)
    end,
}
