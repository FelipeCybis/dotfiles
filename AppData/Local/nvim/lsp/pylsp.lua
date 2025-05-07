return {
  settings = {
    pylsp = {
      plugins = {
        pylsp_mypy = { enabled = true, live_mode = true },
        autopep8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        jedi_completion = { enabled = false },
        jedi_definition = { enabled = false },
        jedi_hover = { enabled = false },
        jedi_references = { enabled = false },
        jedi_signature_help = { enabled = false },
        jedi_symbols = { enabled = false },
        yapf = { enabled = false },
      }
    }
  }
}
