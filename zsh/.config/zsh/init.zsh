# Zsh initialization

# Zim setup
ZIM_HOME="${HOME}/.config/zsh/.zim"
ZIM_CONFIG_FILE="${HOME}/.config/zsh/.zimrc"

# Download zimfw plugin manager if missing
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules
source ${ZIM_HOME}/init.zsh

# Emacs key bindings
bindkey -e

# History settings
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY          # Write timestamp
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_IGNORE_SPACE         # Ignore commands starting with space
setopt HIST_VERIFY               # Show before executing history command
setopt SHARE_HISTORY             # Share history between sessions

# Directory navigation
setopt AUTO_CD                   # Type directory name to cd
setopt AUTO_PUSHD                # Make cd push old dir onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicates
setopt PUSHD_SILENT              # Don't print stack after pushd/popd

# Globbing
setopt EXTENDED_GLOB             # Use extended globbing (#, ~, ^)
setopt GLOB_DOTS                 # Include dotfiles in globs

# Environment variables
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R -F -X"           # Raw color codes, quit if one screen, no init

# Source modular configs
source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/aliases.zsh

# Source system-specific aliases if available
[[ -f ~/.aliases ]] && source ~/.aliases

# AWS CLI completion
if command -v aws_completer &> /dev/null; then
  autoload bashcompinit && bashcompinit
  complete -C aws_completer aws
fi

# Zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Mise
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi
