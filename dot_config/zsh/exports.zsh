export EDITOR="nvim"
export LANGUAGE=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Preview fzf file content using bat
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Cargo
source "$HOME/.cargo/env"

# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# uv completions
eval "$(uv generate-shell-completion zsh)"
#
# just completions
eval "$(just --completions zsh)"

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"
