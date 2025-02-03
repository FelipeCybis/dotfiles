return {
  "echasnovski/mini.surround",
  version = "*",
  event = "VeryLazy",
  config = {
    mappings = {
      add = "gsa",       -- Add surroundng in Normal and Visual modes
      delete = "gsd",    -- Delete surrounding
      find = "gsf",      -- Find surrounding (to the right)
      find_left = "gsF", -- Find surrounding (to the left)
      highlight = "gsh", -- Highlight surrounding
      replace = "gsr",   -- Replace surrounding
    },
    n_lines = 100,
  },
}
