# Define an alias 'venv' to activate the virtual environment
function ActivateVenv {
    & .venv\Scripts\activate
}

# Export the function as an alias
New-Alias -Name "venv" -Scope Global -Value ActivateVenv -ErrorAction Ignore

# Strip the GitHub prefix (HTTPS or SSH) from the origin URL, leaving "owner/repo.git"
function Get-GitHubRepoPath {
    (git remote get-url origin) -replace '^https://github\.com/', '' -replace '^git@github\.com:', ''
}

# Switch Git remote to HTTPS
function git_https {
    git remote set-url origin "https://github.com/$(Get-GitHubRepoPath)"
    Write-Host "Switched to HTTPS: $(git remote get-url origin)"
}

# Switch Git remote to SSH
function git_ssh {
    git remote set-url origin "git@github.com:$(Get-GitHubRepoPath)"
    Write-Host "Switched to SSH: $(git remote get-url origin)"
}

