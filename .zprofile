# ~/.zprofile

export DEFAULT_USER=$USER
export GH_GET_WORKSPACE_PATH="$HOME/dev"
#export TERM=xterm-256color-italic
export EDITOR=hx
export PAGER=less
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

# FZF {{{
export FZF_HOME=$(brew --prefix fzf)
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzfrc"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# }}}

# Added by Toolbox App
export PATH="$PATH:/Users/nblagoev/Library/Application Support/JetBrains/Toolbox/scripts"

[ -f ~/.config/zsh/local_profile.zsh ] && source ~/.config/zsh/local_profile.zsh
