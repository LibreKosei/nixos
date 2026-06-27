function source_if_exists() {
    [[ -f "$1" ]] && source "$1"
}

ZSHAREDIR="/etc/profiles/per-user/kosei/share"

autoload -Uz compinit
compinit

source_if_exists "$ZSHAREDIR/fzf-tab/fzf-tab.plugin.zsh"


source_if_exists "$ZSHAREDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source_if_exists "$ZSHAREDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"


setopt autocd

bindkey -e 

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

alias ..="cd .."
alias ls="eza -1 --icons"
alias mcStat="sudo systemctl status minecraft-server-fabricLatest"
alias mcRestart="sudo systemctl restart minecraft-server-fabricLatest"

# direnv
eval "$(direnv hook zsh)"

# fzf 
source_if_exists "$ZSHAREDIR/fzf/shell/key-bindings.zsh"
source_if_exists "$ZSHAREDIR/fzf/shell/completion.zsh"
# eval "$(fzf --zsh)"

# zoxide
eval "$(zoxide init zsh)"

# yazi wrapper
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cmd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi 
    rm -f -- "$tmp"
}

eval "$(starship init zsh)"
