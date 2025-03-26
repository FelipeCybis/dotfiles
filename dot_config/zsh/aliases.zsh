alias l='ls -la'
alias ls='lsd'
alias ll='ls -l'
alias la='ls -a'
alias lt='ls --tree'
alias lla='ls -la'
alias lat='la --tree'
alias llt='ll --tree'
alias llat='lla --tree'

# Oneliners to switch remote from ssh to https and back
alias git-https="git remote set-url origin https://github.com/$(git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://')"
alias git-ssh="  git remote set-url origin git@github.com:$(git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://')"
