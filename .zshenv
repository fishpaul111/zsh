# XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Keep zsh configuration in this directory.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Ubuntu's global zshrc runs compinit before the user .zshrc.
skip_global_compinit=1
