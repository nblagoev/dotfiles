#
# ~/.zshenv
#

export DEFAULT_USER=$USER
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GH_GET_WORKSPACE_PATH="$HOME/dev"
#export TERM=xterm-256color-italic
export EDITOR=hx
export BAT_THEME="Catppuccin-mocha"
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

eval "$(/opt/homebrew/bin/brew shellenv)"

# Path {{{

  # Extend $PATH without duplicates
  function _extend_path() {
    if ! $( echo "$PATH" | tr ":" "\n" | grep -qx "$1" ) ; then
      PATH="$1:$PATH"
    fi
  }

  [ -d ~/.bin ] && _extend_path "$HOME/.bin"
  [ -d ~/.local/bin ] && _extend_path "$HOME/.local/bin"
  [ -d /usr/local/bin ] && _extend_path "/usr/local/bin"
  [ -d /usr/local/sbin ] && _extend_path "/usr/local/sbin"
  #[ -d ~/.npm-global ] && _extend_path "~/.npm-global/bin"
  _extend_path $(brew --prefix)/opt/llvm/bin
# }}}

source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# Java {{{
  #export JAVA_HOME="$(/usr/libexec/java_home -v 1.8.0_281)"
# }}}

# FZF {{{

export FZF_HOME=$(brew --prefix fzf)

if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == "Dark" ]]; then
  export FZF_DEFAULT_OPTS="
    --prompt='➤ '
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  "
else
  export FZF_DEFAULT_OPTS="
    --prompt='➤ '
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78
    --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39
  "
fi

export FZF_DEFAULT_COMMAND="rg --smart-case --files --hidden --ignore-file=$HOME/.rgignore"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# }}}

. "$HOME/.cargo/env"
