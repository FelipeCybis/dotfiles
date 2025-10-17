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

    -- Function to yank (copy) the full path of the entry under the cursor
    local yank_full_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then
        return vim.notify('Cursor is not on valid entry')
      end
      vim.fn.setreg(vim.v.register, path)
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Set 'gy' to yank the path under cursor
        vim.keymap.set('n', 'gy', yank_full_path, { buffer = buf_id, desc = 'Yank full path' })
      end,
    })
  end,
  keys = {
    {
      "<leader>ee",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "[e]xplorer: mini.files (current file directory)",
    },
    {
      "<leader>eE",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "[e]xplorer: mini.files (working directory)",
    },
  },
}
