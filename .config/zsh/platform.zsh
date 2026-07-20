DOTFILES_WSL=false

case $(uname -s) in
    Darwin)
        DOTFILES_PLATFORM=macos
        ;;
    Linux)
        if [[ -r /etc/os-release ]]; then
            os_release=/etc/os-release
        elif [[ -r /usr/lib/os-release ]]; then
            os_release=/usr/lib/os-release
        else
            os_release=
        fi

        if [[ -n $os_release ]]; then
            DOTFILES_PLATFORM="$(. "$os_release"; print -r -- "${ID:-linux}")"
        else
            DOTFILES_PLATFORM=linux
        fi

        if [[ -n ${WSL_INTEROP:-} ]] ||
            ([[ -r /proc/sys/kernel/osrelease ]] && grep -qi microsoft /proc/sys/kernel/osrelease); then
            DOTFILES_WSL=true
        fi
        ;;
    *)
        DOTFILES_PLATFORM=unknown
        ;;
esac
