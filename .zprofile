# ~/.zprofile

source "$HOME/.config/zsh/platform.zsh"

typeset -U path
_extend_path() {
    [[ -d $1 ]] && path=("$1" "${path[@]}")
}

export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzfrc"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

if [[ $DOTFILES_PLATFORM == macos ]]; then
    export VIMRUNTIME="$XDG_DATA_HOME/bob/$(/bin/cat "$XDG_DATA_HOME/bob/used")/share/nvim/runtime"
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS=--require-sha

    brew_bin=/opt/homebrew/bin/brew
    eval "$("$brew_bin" shellenv)"
    export FZF_HOME="$("$brew_bin" --prefix fzf)"
fi

_extend_path "$HOME/.bin"
_extend_path "$HOME/.local/bin"
_extend_path /usr/local/bin
_extend_path /usr/local/sbin

source "$HOME/.cargo/env"

if [[ $DOTFILES_PLATFORM == macos ]]; then
    _extend_path "$("$brew_bin" --prefix llvm)/bin"
    path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")
    source "$XDG_DATA_HOME/bob/env/env.sh"

    unset brew_bin
fi

[[ -r "$XDG_CONFIG_HOME/zsh/local_profile.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/local_profile.zsh"
