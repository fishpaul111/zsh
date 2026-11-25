# Add common local-install directories when present. System-installed tools
# (for example, in /usr/bin) are already found through the inherited PATH.
typeset -U path
local_bin_dirs=()
for bin_dir in \
    /opt/nvim-linux-x86_64/bin \
    /opt/fzf/bin \
    "$HOME/.fzf/bin" \
    "$HOME/.local/bin" \
    "$HOME/bin"
do
    [[ -d "$bin_dir" ]] && local_bin_dirs+=("$bin_dir")
done
path=($local_bin_dirs $path)

# Optional per-machine PATH additions can go in this file.
[[ -r "$ZDOTDIR/.zprofile.local" ]] && source "$ZDOTDIR/.zprofile.local"

export PATH
