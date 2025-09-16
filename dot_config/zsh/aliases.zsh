alias l='ls -la'
alias ls='lsd'
alias ll='ls -l'
alias la='ls -a'
alias lt='ls --tree'
alias lla='ls -la'
alias lat='la --tree'
alias llt='ll --tree'
alias llat='lla --tree'

# Function to switch Git remote to HTTPS
function git_https() {
    local repo_url
    repo_url=$(git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://')
    git remote set-url origin "https://github.com/$repo_url"
    echo "Switched to HTTPS: $(git remote get-url origin)"
}

# Function to switch Git remote to SSH
function git_ssh() {
    local repo_url
    repo_url=$(git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://')
    git remote set-url origin "git@github.com:$repo_url"
    echo "Switched to SSH: $(git remote get-url origin)"
}

# Define an alias 'venv' to activate the virtual environment
alias venv='source .venv/bin/activate'
