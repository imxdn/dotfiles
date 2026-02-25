# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Better defaults
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# List directory contents (using eza)
alias ls='eza --color=always --icons'
alias l='eza -lah --icons'
alias la='eza -lAh --icons'
alias ll='eza -lh --icons'
alias lt='eza -lah --tree --level=2 --icons'

# Better cat
alias cat='bat --style=auto'

# Shortcuts
alias h='history'
alias c='clear'
alias q='exit'
alias v='nvim'

# Tmux
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tn='tmux new -s'
alias tk='tmux kill-session -t'

# Reload zsh config
alias reload='source ~/.zshrc'
