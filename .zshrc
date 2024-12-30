# ~/.zshrc

# zmodload zsh/zprof

if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# Start tmux by default in Alacritty and exit terminal if tmux exits.
if [[ -n "$ALACRITTY_SOCKET" && -z "$TMUX" ]] ; then
  echo -e "\n\nAttaching tmux..."
  tmux attach-session || exec tmux new-session;
fi

source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load $HOME/.zplugins

eval "$(fzf --zsh)"
eval "$(navi widget zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

for filename in $HOME/.config/zsh/{aliases,commands,options,completion,keybindings}.zsh; do
    source $filename
done
unset filename

[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
[ -f ~/.config/zsh/localrc.zsh ] && source ~/.config/zsh/localrc.zsh

source $HOME/.cargo/env

# ~/.local/bin/cleanup-history ~/.history
# fc -R # reload history
# trap "~/.local/bin/cleanup-history ~/.history" EXIT
