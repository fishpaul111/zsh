# default programs
export EDITOR="nvim"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/opt/fzf/bin"
# export DISPLAY=:0 # useful for some scripts

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# bootstrap .zshrc to ~/.config/zsh/.zshrc, any other zsh config files can also reside here
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Aliases
alias \
\
configzsh='$EDITOR $ZDOTDIR/.zshrc' \
reloadzsh='source $ZDOTDIR/.zshrc' \
l="ls -lh --color=auto --group-directories-first" \
ls="ls -h --color=auto --group-directories-first" \
la="ls -lah --color=auto --group-directories-first" \
grep="grep --color=auto" \

# load modules
zmodload zsh/complist
autoload -U compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
autoload -U colors && colors

# setup fzf
source <(fzf --zsh)

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
# zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

# main opts
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

# fzf setup
source <(fzf --zsh) # allow for fzf history widget

# binds
bindkey '^R' fzf-history-widget
# ctrl J & K for going up and down in prev commands
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward

# set up prompt
setopt PROMPT_SUBST
git_rprompt() {
  [[ -e .git ]] || return  # only when .git exists in *current* dir
  local branch dirty
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return
  git diff --quiet --ignore-submodules HEAD 2>/dev/null
  dirty=$([[ $? -eq 0 ]] && echo "" || echo "*")
  echo " ${branch}${dirty}"
}
NEWLINE=$'\n'
PROMPT=$NEWLINE'%B%F{blue}(%2~)%f %F{49}'$NEWLINE'❯%f%b '
RPROMPT=$'%{\e[1A%}%F{8}$(git_rprompt) [%*]%f%{\e[1B%}'

# autosuggestions
# requires zsh-autosuggestions
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
# requires zsh-syntax-highlighting package
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
