# ---------------------------------------------------------
# 1. HOMEBREW INITIALIZATION (AI AGENT PERSISTENCE)
# ---------------------------------------------------------
# Proactively initialize Homebrew based on architecture.
# This ensures agents can always find 'brew', 'node', 'python', etc.
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ---------------------------------------------------------
# 2. GLOBAL BINARY PATHS (FIX "COMMAND NOT FOUND")
# ---------------------------------------------------------
# Ensure paths for common AI tool managers are loaded
# Prevents errors when agents try to run globally installed npm/pip tools.
typeset -U path  # Keep PATH unique (prevents duplicates)

# Add Homebrew and User binaries to the FRONT of the path
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  $path
)

# Add Node/NPM global binaries if they exist
if command -v npm &> /dev/null; then
  export PATH="$(npm prefix -g)/bin:$PATH"
fi

# ---------------------------------------------------------
# 3. AI AGENT ENVIRONMENT VARIABLES
# ---------------------------------------------------------
# Optional: Set specific variables used by common agents
export CLAUDE_CODE_SHELL="zsh"  # Hints to Claude to use your Zsh config
export EDITOR="code --wait"     # Default editor for agent-initiated edits

# ---------------------------------------------------------
# 4. COMPLETION & PLUGINS (ENHANCE AGENT CONTEXT)
# ---------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select  # Allow agents to "see" completion menus

# ---------------------------------------------------------
# 5. ALIASES FOR AI WORKFLOWS
# ---------------------------------------------------------
alias ccode="claude"
alias refresh="source ~/.zshrc"
