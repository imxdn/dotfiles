# FZF Configuration

# Commands
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# Default options
export FZF_DEFAULT_OPTS=" \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --height=40% \
  --multi \
  --cycle \
  --preview-window=right:50%:wrap \
  --color=fg:#908caa \
  --color=bg:#191724 \
  --color=hl:#ebbcba \
  --color=fg+:#e0def4 \
  --color=bg+:#26233a \
  --color=hl+:#ebbcba \
  --color=border:#403d52 \
  --color=header:#31748f \
  --color=gutter:#191724 \
  --color=spinner:#f6c177 \
  --color=info:#9ccfd8 \
  --color=pointer:#c4a7e7 \
  --color=marker:#eb6f92 \
  --color=prompt:#908caa"

# Widget options
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target \
  --preview 'bat -n --color=always {}' \
  --preview-window=right:60%:wrap \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_ALT_C_OPTS="--walker-skip .git,node_modules,target \
  --preview 'eza --tree --color=always {} | head -200 2>/dev/null || tree -C {} | head -200 2>/dev/null || ls -la {}' \
  --preview-window=right:50%:wrap \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="--sort \
  --exact \
  --bind 'ctrl-/:toggle-sort' \
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
  --color 'header:italic' \
  --header 'Press CTRL-Y to copy command into clipboard'"

# Tmux integration
export FZF_TMUX_OPTS="-p 80%,60%"
