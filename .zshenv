#
# ~/.zshenv
#

# Defines environment variables.
export ENABLE_SPRING=0
export DEFAULT_USER=$USER
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GIT_CLONEP_PATH="$HOME/dev"
#export TERM=xterm-256color-italic
export SSH_KEY_PATH="~/.ssh/rsa_id"
export KEYID=0x84C1F7D9ECED9549
export EDITOR="~/.local/bin/vim-wrapper"
export BAT_THEME="TwoDark"
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

eval "$(/opt/homebrew/bin/brew shellenv)"

# Path {{{

  # recommended by brew doctor {{{
    export PATH="/usr/local/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
    #export PATH=$(brew --prefix openssh)/bin:$PATH
  # }}}

  # Extend $PATH without duplicates
  function _extend_path() {
    if ! $( echo "$PATH" | tr ":" "\n" | grep -qx "$1" ) ; then
      PATH="$1:$PATH"
    fi
  }

  # Add custom bin to $PATH
  [ -d ~/.bin ] && _extend_path "$HOME/.bin"
  [ -d ~/.local/bin ] && _extend_path "$HOME/.local/bin"
  #[ -d /usr/local/MacGPG2/bin ] && _extend_path "/usr/local/MacGPG2/bin"
  #[ -d ~/.npm-global ] && _extend_path "~/.npm-global/bin"
# }}}

# Java {{{
  #export JAVA_HOME="$(/usr/libexec/java_home -v 1.8.0_281)"
# }}}

# FZF {{{
 export FZF_HOME=$(brew --prefix fzf)
 export FZF_DEFAULT_OPTS="
  --prompt='➤ '
  --color fg:223,bg:236,hl:245,fg+:223,bg+:237,hl+:11
  --color info:81,prompt:167,pointer:167,marker:167,spinner:167,header:245
"
export FZF_DEFAULT_COMMAND="rg --smart-case --files --hidden --ignore-file=$HOME/.rgignore"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# }}}
