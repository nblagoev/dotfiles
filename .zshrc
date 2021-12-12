#
# ~/.zshrc
#

#zmodload zsh/zprof

# Start tmux by default and exit terminal if tmux exits. {{{
#  if [[ -n "$TMUX" || "$AUTOSTART_TMUX" = "no" ]] ; then
#    # export TERM=screen-256color-italic
#  else
#    tmux attach-session || exec tmux new-session;
#    #tmux attach-session || exec tmux new-session && exit;
#  fi
# }}}

if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

#export SSH_AUTH_SOCK="/usr/local/var/run/yubikey-agent.sock"
#export GPG_TTY="$(tty)"
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#gpgconf --launch gpg-agent

source ~/.aliases.sh
source ~/.functions.sh

# ZSH highlighting settings {{{
typeset -A ZSH_HIGHLIGHT_PATTERNS

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red,bold')
#ZSH_HIGHLIGHT_PATTERNS+=('sudo*' 'fg=white,bold,bg=red,bold')

ZSH_HIGHLIGHT_PATTERNS+=('\|' 'fg=magenta,bold')
ZSH_HIGHLIGHT_PATTERNS+=('>' 'fg=magenta,bold')
ZSH_HIGHLIGHT_PATTERNS+=('>>' 'fg=magenta,bold')

# Highlight MAC addresses, IPs.
ZSH_HIGHLIGHT_PATTERNS+=('[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]' 'fg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=(' [0-9]##.[0-9]##.[0-9]##.[0-9]##' 'fg=yellow')

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
# }}}


# History options {{{
HISTFILE=~/.history
HISTSIZE=50000
SAVEHIST=50000

setopt append_history
setopt extended_history
setopt -g hist_expire_dups_first
setopt -g hist_ignore_dups # ignore duplication command history list
setopt -g HIST_IGNORE_ALL_DUPS
setopt -g HIST_FIND_NO_DUPS
setopt -g HIST_SAVE_NO_DUPS
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
#}}}


# Zplug plugin definitions {{{
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-autosuggestions

zplug "plugins/gulp", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh, defer:3
zplug "plugins/httpie",   from:oh-my-zsh, defer:3

zplug "zsh-users/zsh-history-substring-search"

zplug hlissner/zsh-autopair
#zplug akoenig/npm-run.plugin.zsh

zplug "Aloxaf/fzf-tab", from:github
# }}}

# Zplug {{{
# Can manage local plugins
# zplug "~/.zsh", from:local

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

# Key Bindings {{{
# Emacs mode
bindkey -e
export KEYTIMEOUT=1

# list branches
zle     -N   branch-widget
bindkey '^B' branch-widget

# Launch FZF -> vim
bindkey -s '\C-p' "\C-k \C-u vimfzf\n"

# sudo-ize command
bindkey -s '\C-s' "\C-asudo \C-e"

# use ^F for file completion instead of ^T
bindkey '^F' fzf-file-widget

#  bindkey '^e' autosuggest-accept

if zplug check zsh-users/zsh-history-substring-search; then
#    zmodload zsh/terminfo
#    bindkey "$terminfo[kcuu1]" history-substring-search-up
#    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# }}}

# completions {{{
zmodload zsh/complist
autoload -U compinit && compinit

# Set options
setopt MENU_COMPLETE       # press <Tab> one time to select item
setopt COMPLETEALIASES     # complete alias
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
unsetopt FLOW_CONTROL # Disable start/stop characters in shell editor.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'


# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Populate hostname completion. But allow ignoring custom entries from static
# */etc/hosts* which might be uninteresting.
zstyle -a ':prezto:module:completion:*:hosts' etc-host-ignores '_etc_host_ignores'

zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns '_*'

# auto rehash
zstyle ':completion:*' rehash true

#highlight prefix
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")'

# SSH/SCP/RSYNC
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

#fzf-tab config
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle ':fzf-tab:*' fzf-bindings 'space:accept,backward-eof:abort'   # Space as accept, abort when deleting empty space
zstyle ':fzf-tab:*' accept-line enter         # Accept selected entry on enter
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' prefix ''                 # No dot prefix
zstyle ':fzf-tab:*' single-group color header # Show header for single groups
zstyle ':fzf-tab:complete:(cd|ls|ll):*' fzf-preview '[[ -d $realpath ]] && exa -1 --group-directories-first --color=always -- $realpath'
zstyle ':fzf-tab:complete:((micro|cp|rm|bat|less|code|vim):argument-rest|kate:*)' fzf-preview 'bat --color=always -- $realpath 2>/dev/null || ls --color=always -- $realpath'
zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-preview "git --git-dir=$UPDATELOCAL_GITDIR/\${word}/.git log --color --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset ||%b' ..FETCH_HEAD 2>/dev/null"
zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-flags --preview-window=down:5:wrap

# }}}


# Fix for 'widgets can only be called when ZLE is active.' {{{
# https://stackoverflow.com/questions/20357441/zsh-on-10-9-widgets-can-only-be-called-when-zle-is-active
#  TRAPWINCH() {
#    zle && { zle reset-prompt; zle -R }
#  }
# }}}

# FZF {{{
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

~/.local/bin/cleanup-history ~/.history
fc -R # reload history

eval "$(navi widget zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

trap "~/.local/bin/cleanup-history ~/.history" EXIT

# vim: foldmethod=marker:sw=2
