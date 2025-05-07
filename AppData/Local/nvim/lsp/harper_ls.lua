return {
  settings = {
    ["harper-ls"] = {
      linters = {
        Spaces = false,
        LongSentences = false,
      },
      codeActions = {
        ForceStable = true
      },
      diagnosticSeverity = "hint" -- "information", "warning", or "error"
    }
  },
}
