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
bindkey -s '\C-e' "\C-k \C-u dotfzf\n"

# Launch FZF -> vim
bindkey -s '\C-o' "\C-k \C-u vimfzf\n"

# sudo-ize command
bindkey -s '\C-s' "\C-asudo \C-e"

# use ^F for file completion instead of ^T
bindkey '^F' fzf-file-widget

# zmodload zsh/terminfo
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^R' fzf-history-widget

function zle-keymap-select zle-line-init
{
       # change cursor shape in xterm
       case $KEYMAP in
               vicmd)      echo -e -n "\x1b[\x32 q";;  # block cursor
               viins|main) echo -e -n "\x1b[\x35 q";;  # blinking line cursor
       esac

       zle reset-prompt
       zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select
