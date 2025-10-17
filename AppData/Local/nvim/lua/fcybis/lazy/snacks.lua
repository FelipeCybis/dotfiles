return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = true },
    bigfile = { enabled = true },
    explorer = { enabled = true, replace_netrw = true },
    indent = { enabled = true },
    input = { enabled = true },
    image = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scratch = { enabled = true },
    scroll = { enabled = false, animate = { duration = { step = 10, total = 60 } } },
    statuscolumn = { enabled = true },
    styles = {
      ---@diagnostic disable-next-line
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
    toggle = { enabled = true, icon = { enabled = " ", disabled = " " } },
    words = { enabled = true },
  },
  keys = function()
    -- requiring Snacks here only to have lsp info available
    local Snacks = require('snacks')
    local shell = (vim.fn.has('win32') == 1) and "pwsh" or "zsh"
    return {
      { '<leader>dn', function() Snacks.notifier.hide() end,           desc = '[d]ismiss [n]otifications' },
      { '<leader>bd', function() Snacks.bufdelete() end,               desc = '[b]uffer: [d]elete' },
      { '<leader>bs', function() Snacks.scratch() end,                 desc = '[b]uffer: make [s]cratch' },
      { '<leader>lg', function() Snacks.lazygit() end,                 desc = '[L]azy[g]it' },
      { '<leader>gl', function() Snacks.git.blame_line() end,          desc = '[g]it: blame [l]ine' },
      { '<leader>gr', function() Snacks.gitbrowse() end,               desc = '[g]it: [r]emote url' },
      { '<leader>lR', function() Snacks.rename.rename_file() end,      desc = '[l]SP: [R]ename File' },
      { '<leader>et', function() Snacks.picker.explorer() end,         desc = '[e]xplorer: [t]ree' },
      { '<leader>tt', function() Snacks.terminal.toggle(shell) end,    desc = '[t]erminal: [t]oggle floating' },
      { '<leader>ts', function() Snacks.terminal() end,                desc = '[t]erminal: [s]plit' },
      { ']n',         function() Snacks.words.jump(vim.v.count1) end,  desc = 'Next Reference (snacks)' },
      { '[n',         function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference (snacks)' },
      { '<leader>fl', function() Snacks.picker.lazy() end,             desc = '[f]ind: [l]azy cfg files' },
      { '<leader>fP', function() Snacks.picker.projects() end,         desc = '[f]ind: [P]rojects' },
      { '<leader>fr', function() Snacks.picker.recent() end,           desc = '[f]ind: [r]ecent' },
      { '<leader>si', function() Snacks.picker.icons() end,            desc = '[s]earch: [i]cons' },
      { '<leader>ss', function() Snacks.scratch.select() end,          desc = '[s]earch: [s]cratch Buffer' },
      { '<leader>sn', function() Snacks.notifier.show_history() end,   desc = '[s]earch: [n]otifier history' },
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
        Snacks.toggle.diagnostics():map('<leader>ud')
        Snacks.toggle.line_number():map('<leader>ul')
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map('<leader>uc')
        Snacks.toggle.treesitter():map('<leader>uT')
        Snacks.toggle.scroll():map('<leader>uS')
      end,
    })
  end,
}
