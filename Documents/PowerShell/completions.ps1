# wezterm completions
if (Get-Command wezterm -errorAction SilentlyContinue) {
    wezterm shell-completion --shell power-shell | Out-String | Invoke-Expression
}

# chezmoi completions
if (Get-Command chezmoi -errorAction SilentlyContinue) {
    chezmoi completion powershell | Out-String | Invoke-Expression
}

# uv completions
if (Get-Command uv -errorAction SilentlyContinue) {
    uv generate-shell-completion powershell | Out-String | Invoke-Expression
}
