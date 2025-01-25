export EDITOR="nvim"
export TERMINAL="wezterm"
export LANGUAGE=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Rye
source "$HOME/.rye/env"
eval "$(rye self completion -s zsh)"

# Cargo
source "$HOME/.cargo/env"

# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


eval "$(zoxide init zsh)"

eval "$(starship init zsh)"
