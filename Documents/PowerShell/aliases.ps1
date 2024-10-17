# Define an alias 'venv' to activate the virtual environment
function ActivateVenv {
    & .venv\Scripts\activate
}

# Export the function as an alias
New-Alias -Name "venv" -Scope Global -Value ActivateVenv -ErrorAction Ignore

