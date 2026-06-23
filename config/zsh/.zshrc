source /run/current-system/sw/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source /run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /run/current-system/sw/share/fzf-tab/fzf-tab.plugin.zsh 

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
source /run/current-system/sw/share/fzf/shell/key-bindings.zsh 
eval "$(fzf --zsh)"

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
