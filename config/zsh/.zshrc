# Path to omz installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="refined"

# Plugins
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zoxide
)

# Load omz
source $ZSH/oh-my-zsh.sh

# -------------------------
# Aliases
# -------------------------
alias ll='ls -lah'          # Detailed list, human-readable
alias la='ls -A'            # List all except . and ..
alias cd='z'                # Use zoxide for cd

# -------------------------
# PATH
# -------------------------
# Homebrew
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

# Local scripts
export PATH="$HOME/.local/bin:$PATH"

# -------------------------
# History
# -------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history       # Append to history instead of overwriting
setopt share_history        # Share history across sessions
