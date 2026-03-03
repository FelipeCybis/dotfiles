return {
  settings = {
    basedpyright = {
      -- Using Ruff"s import organizer.
      disableOrganizeImports = true,
      analysis = {
        -- Ignore all files for analysis to exclusively use
        -- Ruff for linting.
        -- ignore = { "*" },
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
        },
        -- I use too many packages that don't have stubs.
        typeCheckingMode = "basic",
      },
    },
  },
}
