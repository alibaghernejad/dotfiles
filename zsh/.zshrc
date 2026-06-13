# Paths to the Dotfiles and More.
DOTFILES_HOME="${XDG_DATA_HOME:-${HOME}/dotfiles}"
DOTFILES_HOME_ZSH="${DOTFILES_HOME}/zsh"
DOTFILES_HOME_ZSH_PLUGIN_MANAGERS="${DOTFILES_HOME_ZSH}/plugin-managers"

# Load Plugin manager
source "${DOTFILES_HOME_ZSH_PLUGIN_MANAGERS}/zinit.zsh"


