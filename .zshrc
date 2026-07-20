# ~/.zshrc

# zmodload zsh/zprof

source "$XDG_CONFIG_HOME/zsh/platform.zsh"

if [[ $TERM = dumb ]]; then
    unset zle_bracketed_paste
fi

# Start tmux by default in Alacritty and exit terminal if tmux exits.
if [[ -n $ALACRITTY_SOCKET && -z $TMUX ]]; then
    echo -e "\n\nAttaching tmux..."
    tmux attach-session || exec tmux new-session
fi

# Set plugin options before Antidote loads plugins.
source "$XDG_CONFIG_HOME/zsh/options.zsh"

if [[ $DOTFILES_PLATFORM == macos ]]; then
    source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
    [ -f "$XDG_CONFIG_HOME/op/plugins.sh" ] && source "$XDG_CONFIG_HOME/op/plugins.sh"
else
    source "$XDG_DATA_HOME/antidote/antidote.zsh"
fi

antidote load "$HOME/.zplugins"

mkdir -p "$HOME/.cache"
autoload -Uz compinit
if [[ ! -f $HOME/.cache/zcompdump.zwc ]]; then
    compinit -d "$HOME/.cache/zcompdump"
    zcompile "$HOME/.cache/zcompdump"
else
    compinit -C -d "$HOME/.cache/zcompdump"
fi

eval "$(fzf --zsh)"
eval "$(navi widget zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

for filename in "$XDG_CONFIG_HOME"/zsh/{aliases,commands,completion,keybindings}.zsh; do
    source "$filename"
done
unset filename

[[ -r "$XDG_CONFIG_HOME/zsh/localrc.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/localrc.zsh"

# ~/.local/bin/cleanup-history ~/.history
# fc -R # reload history
# trap "~/.local/bin/cleanup-history ~/.history" EXIT

# zprof
