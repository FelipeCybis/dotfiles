export EDITOR="nvim"
export LANGUAGE=en_US.UTF-8
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Preview fzf file content using bat
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"


# opencode
export PATH=/home/fpereir/.opencode/bin:$PATH

# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


