# ~/.zshrc

#zmodload zsh/zprof

if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# Start tmux by default and exit terminal if tmux exits.
if [[ -n "$TMUX" || "$AUTOSTART_TMUX" = "no" || -n "$INTELLIJ_ENVIRONMENT_READER" || -n "$VSCODE_PID" ]] ; then
   #export TERM=screen-256color-italic
else
  echo -e "\n\nAttaching tmux..."
  tmux attach-session || exec tmux new-session;
fi

# Zplug plugin definitions {{{
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug zplug/zplug, hook-build:'zplug --self-manage'
zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-autosuggestions
#zplug plugins/kubectl, from:oh-my-zsh
zplug plugins/docker, from:oh-my-zsh
zplug plugins/git, from:oh-my-zsh, defer:3
zplug zsh-users/zsh-history-substring-search
zplug hlissner/zsh-autopair
#zplug akoenig/npm-run.plugin.zsh
zplug "Aloxaf/fzf-tab", from:github
# }}}

# Zplug {{{
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "

  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
# Only source zplugins when a new terminal is opened not when source ~/.zshrc
# This is due to conflict between some plugins that causes a crash
# https://github.com/zsh-users/zsh-autosuggestions/issues/205
if [[ $ZSH_EVAL_CONTEXT == 'file' ]]; then
  zplug load
fi
# }}}


# Fix for 'widgets can only be called when ZLE is active.' {{{
# https://stackoverflow.com/questions/20357441/zsh-on-10-9-widgets-can-only-be-called-when-zle-is-active
#  TRAPWINCH() {
#    zle && { zle reset-prompt; zle -R }
#  }
# }}}

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

~/.local/bin/cleanup-history ~/.history
fc -R # reload history
trap "~/.local/bin/cleanup-history ~/.history" EXIT
