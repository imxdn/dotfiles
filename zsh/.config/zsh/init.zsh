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

# Source modular configs
source ~/.config/zsh/fzf.zsh

# Source aliases if available
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
