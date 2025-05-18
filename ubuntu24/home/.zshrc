##  Zsh vars and options
setopt interactive_comments
skip_global_compinit=1


##  Zsh key bindings
bindkey -e
bindkey '^U' push-input


##  Zsh aliases
alias history='builtin fc -il'
alias ls='command ls --color=auto --time-style=long-iso --group-directories-first'
alias ll='command ls --color=auto --time-style=long-iso --group-directories-first --classify --format=long --all'
alias  l='command ls --color=auto --time-style=long-iso --group-directories-first --classify --format=long --almost-all'

alias cz='command chezmoi'


##  Zsh history
HISTFILE=${HISTFILE:-"$HOME/.zsh_history"}
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt  \
    extended_history \
    share_history \
    hist_find_no_dups \
    hist_ignore_space \
    hist_ignore_dups \
    hist_no_store \
    hist_reduce_blanks \
    hist_verify \

# Prompt
autoload -Uz promptinit
promptinit
prompt adam1

# Enable completion system
autoload -Uz compinit
compinit

# Completion fine-tuning using zstyle
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'

# Case-insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
