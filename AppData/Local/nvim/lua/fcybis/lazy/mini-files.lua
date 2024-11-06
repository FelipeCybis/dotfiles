return {
    'echasnovski/mini.files',
    version = '*',
    config = function()
        local MiniFiles = require('mini.files')
        MiniFiles.setup()

        local files_set_cwd = function(path)
            -- Works only if cursor is on the valid file system entry
            local cur_entry_path = MiniFiles.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
            vim.notify('Directory changed to ' .. cur_directory)
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function(args)
                vim.keymap.set('n', 'gt', files_set_cwd, { buffer = args.data.buf_id, desc = 'Set cwd to current file' })
            end,
        })
    end,
    keys = {
        {
            "<leader>e",
            function()
                require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
            end,
            desc = "Open mini.files (Directory of Current File)",
        },
        {
            "<leader>E",
            function()
                require("mini.files").open(vim.uv.cwd(), true)
            end,
            desc = "Open mini.files (cwd)",
        },
    },
}
