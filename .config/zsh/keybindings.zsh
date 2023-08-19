# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Fix zsh not deleting non-inserted character in vi mode
bindkey "^?" backward-delete-char

# Move between words with Alt-arrows
# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# list branches
zle     -N   branch-widget
bindkey '^B' branch-widget

# Edit dotfile
#bindkey -s '^[.' "\C-k \C-u dotfzf\n"

# Launch FZF -> vim
bindkey -s '\C-p' "\C-k \C-u vimfzf\n"

# sudo-ize command
bindkey -s '\C-s' "\C-asudo \C-e"

# use ^F for file completion instead of ^T
bindkey '^F' fzf-file-widget

if zplug check zsh-users/zsh-history-substring-search; then
#    zmodload zsh/terminfo
#    bindkey "$terminfo[kcuu1]" history-substring-search-up
#    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# If we're in tmux, then ^A is our prefix. Otherwise, bind it to 'move a thing
# into tmux'. This only works on Linux.
function ctrla() {
    if [[ -e "$TMUX" ]] && (( $+commands[reptyr] )); then
        kill -TSTP $$
        bg >/dev/null 2>&1
        disown
        tmux new-window "$SHELL -c 'reptyr $$'"
        tmux attach
    else
        zle push-input
    fi
}
