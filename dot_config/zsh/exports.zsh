export EDITOR="vim"
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
