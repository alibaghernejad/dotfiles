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
DOTFILE_HOME_SCRIPTS_EDITORS_FILE="$DOTFILES_HOME_SCRIPTS/default-editor.sh" 
source $DOTFILE_HOME_SCRIPTS_EDITORS_FILE


# --- Aliases ---
source "${DOTFILES_HOME}/shell-common/aliases"


# --- Load Plugin Manager ---
source "${DOTFILES_HOME_ZSH_PLUGINS}/zinit/init.zsh"

# --- Completions ---

# Snippet-Store Completions
#compdef _snippet_box snippet-box
source ~/.snippet-store-completion

zinit light zsh-users/zsh-completions

# Use FZF Menu and Fuzzy Finding capability for completions.
# Replaces already exists completion menu with a new FZF-powered one.
zinit light Aloxaf/fzf-tab

# Completion Styles
# Disable default ZSH Completion menu
zstyle ':completion:*' menu no

# Configure completions to be case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Configure to have colors for files and folder
# It's in addition to overriding the `ls` command in aliases.
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

# Add Preview capability for the File and Folders completions
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Add Preview capability for Zoxide
zstyle ':fzf-tab:complete:__zocide_z:*' fzf-preview 'ls --color $realpath'

# --- Suggestions ---
zinit light zsh-users/zsh-autosuggestions


# --- Load Completions ---
autoload -Uz compinit && compinit

# After autoload command
# Used by Zinit to replay all cached completions, which is recommended by Documentation
zinit cdreplay -q

# --- Load Propmpt ---
source "${DOTFILES_HOME_ZSH_PROMPTS}/powerlevel10k/zinit.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#--- Key Bindings ---
# Enbale EMACS Standard Key-Bindings
bindkey -e

# Override Cycling through History Commands
# Even though enabling EMACS mode (bindkey -e), inherit the default standard key-bindings (like C-p/C-n), but 
# Overriding them allows the user to cycle through the results that match the prefix. What the default behaviour doesn't provides.
# E.g. Typing `curl` and then C-p|C-n will respect the prefix and show History Items that starts with this `curl`.
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Used to delete text chunks
bindkey '^[w' kill-region

#--- HISTORY ---
# How many commands to keep in the current session's memory
# Short-Term Memory (The RAM component)
HISTSIZE=10000

# How many commands to save in your history file (~/.bash_history)
# -Logn-term Memory (The DISK Component)
SAVEHIST=50000

# The file used to store all command history.
HISTFILE=~/.zsh_history

# Remove duplicate entries within the history file.
HISTDUP=erase

# Record the timestamp of when the command was run
# This is incredibly helpful for debugging or looking back at what you did yesterday
HISTTIMEFORMAT="%F %T "

# ZSH History Options
# Append commands to the history file instead of overwriting it.
setopt appendhistory

# Share command history across all active ZSH sessions simultaneously.
setopt sharehistory

# Prevent commands from being saved to history by adding a leading space.
# - This reduces redundant/duplicate entries in the history file.
# - It is useful for preventing sensitive information from being recorded.
# - While using a secret manager like `Pass` is highly recommended, 
#   this provides an extra layer of protection when using secrets in any shell.
setopt hist_ignore_space
# Prevents the same command from appearing twice in a row
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# --- SHELL Integrations ---

# FZF Integration
# Source FZF bindings into the shell emulator
#source <(fzf --zsh)
eval "$(fzf --zsh)"
# Zoxide Integration
eval "$(zoxide init  zsh)"

