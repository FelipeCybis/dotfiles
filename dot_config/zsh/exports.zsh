export EDITOR="nvim"
export TERMINAL="wezterm"
export LANGUAGE=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Cargo
source "$HOME/.cargo/env"

# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# uv completions
eval "$(uv generate-shell-completion zsh)"

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"
