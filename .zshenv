# Zsh
export ZDOTDIR="$HOME/.config/zsh"

export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Misc
export KEYTIMEOUT=1

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# Fzf
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border"

# Zinit
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
