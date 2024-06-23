typeset -U path fpath

# Macos
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

# Zinit 
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# Autoloads
autoload -Uz compinit && compinit
autoload -Uz edit-command-line

# Zle
zle -N edit-command-line

# History
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Keybindings
bindkey -v
bindkey -M vicmd . edit-command-line
bindkey "^?" backward-delete-char

# Aliases
alias ls="ls --color=auto"
alias ..="cd .."

# Source files
source "$ZDOTDIR/.p10k.zsh"

# Orbstack
if [ -f "$HOME/.orbstack/shell/init.zsh" ]; then
    source "$HOME/.orbstack/shell/init.zsh"
fi

# Rust
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# FNM
if [ "$(command -v fnm)" != "" ]; then
    eval "$(fnm env --use-on-cd)"
fi
