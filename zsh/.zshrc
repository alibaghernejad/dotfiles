#
# ==============================================================================
# ZSH CONFIGURATIONS
# ALI BAGHERNEJAD
# ==============================================================================

# --- Powerlevel10k Instant Prompt ---
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you're using Mac OS
# Make any homebrew installed apps available on your paths
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Defaults & Initialization ---
DOTFILES_HOME="${XDG_DATA_HOME:-${HOME}/dotfiles}"
DOTFILES_HOME_ZSH="${DOTFILES_HOME}/zsh"
DOTFILES_HOME_ZSH_PLUGINS="${DOTFILES_HOME_ZSH}/plugins"
DOTFILES_HOME_ZSH_PROMPTS="${DOTFILES_HOME_ZSH}/prompts"
DOTFILES_HOME_SCRIPTS="$DOTFILES_HOME/scripts"

# Load Plugin manager
source "${DOTFILES_HOME_ZSH_PLUGIN_MANAGERS}/zinit.zsh"


