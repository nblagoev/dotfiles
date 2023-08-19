# ZSH highlighting settings
typeset -A ZSH_HIGHLIGHT_PATTERNS

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red,bold')
#ZSH_HIGHLIGHT_PATTERNS+=('sudo*' 'fg=white,bold,bg=red,bold')

ZSH_HIGHLIGHT_PATTERNS+=('\|' 'fg=magenta,bold')
ZSH_HIGHLIGHT_PATTERNS+=('>' 'fg=magenta,bold')
ZSH_HIGHLIGHT_PATTERNS+=('>>' 'fg=magenta,bold')

# Highlight MAC addresses, IPs.
ZSH_HIGHLIGHT_PATTERNS+=('[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]' 'fg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=(' [0-9]##.[0-9]##.[0-9]##.[0-9]##' 'fg=yellow')

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root line)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'


# History options
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


# Completion options
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
