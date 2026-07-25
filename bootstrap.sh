#!/bin/sh

ORIGIN=https://github.com/nblagoev/dotfiles.git

# exit on error
set -e

printf '\n\e[1;32m%s\e[m\n' "OS detection..."

kernel=$(uname -s)
raw_arch=$(uname -m)
arch=
distro=
version=unknown
wsl=false
platform=
bootstrap_script=

case "$kernel" in
    Darwin)
        if [ "$raw_arch" != "arm64" ]; then
            >&2 echo "Unsupported macOS architecture: $raw_arch"
            exit 1
        fi

        arch=arm64
        distro=macos
        version=$(sw_vers -productVersion 2>/dev/null || printf '%s' unknown)
        platform=macos
        bootstrap_script=MACOS.sh
        ;;
    Linux)
        case "$raw_arch" in
            x86_64|amd64)
                arch=x86_64
                ;;
            aarch64|arm64)
                arch=aarch64
                ;;
            *)
                arch=$raw_arch
                ;;
        esac

        if [ -r /etc/os-release ]; then
            os_release=/etc/os-release
        elif [ -r /usr/lib/os-release ]; then
            os_release=/usr/lib/os-release
        else
            >&2 echo "Cannot identify Linux distribution (arch=$arch)"
            exit 1
        fi

        . "$os_release"
        distro=${ID:-}
        version=${VERSION_ID:-unknown}

        if [ -z "$distro" ]; then
            >&2 echo "Cannot identify Linux distribution ID (arch=$arch)"
            exit 1
        fi

        if [ -n "${WSL_INTEROP:-}" ]; then
            wsl=true
        elif [ -r /proc/sys/kernel/osrelease ] && grep -qi microsoft /proc/sys/kernel/osrelease; then
            wsl=true
        fi

        case "$distro" in
            fedora)
                platform=fedora
                bootstrap_script=FEDORA.sh
                ;;
            *)
                platform=unsupported
                ;;
        esac
        ;;
    *)
        >&2 echo "Unsupported kernel: $kernel (arch=$raw_arch)"
        exit 1
        ;;
esac

printf 'os=%s version=%s arch=%s wsl=%s\n' "$distro" "$version" "$arch" "$wsl"

if [ "$platform" = "unsupported" ]; then
    >&2 echo "Unsupported Linux distribution: id=$distro arch=$arch"
    exit 1
fi

# authorise sudo early on
if ! sudo -n echo 2>/dev/null; then
    echo "Please enter sudo password. Sudo session will be kept alive until this script exits."
    # sudo -v is technically correct but asks for a non-existent password on fresh AWS Ubuntu AMIs
    sudo echo -n
fi

# sudo keepalive. This will keep the sudo watchdog fed until this script exits.
# This works by poking the parent process to see if it's still alive.
while true; do sudo -n true; sleep 15; kill -0 "$$" || exit; done 2>/dev/null &
sudo_keepalive_pid=$!
cleanup_sudo_keepalive() {
    kill "$sudo_keepalive_pid" 2>/dev/null || true
}
trap cleanup_sudo_keepalive 0
trap 'exit 1' 1 2 15

printf '\n\e[1;32m%s\e[m\n' "Bootstrapping..."

# make sure git/sudo is installed
case "$platform" in
    macos)
        # triggers install of xcode cli tools or effectively does nothing
        git --version
        ;;
esac

dotfiles_dir="$HOME/.dotfiles"
backup_dir="$HOME/.dotfiles-backup"

if [ ! -d "$dotfiles_dir" ]; then
    command git clone --recurse-submodules --bare "$ORIGIN" "$dotfiles_dir"
fi

dot() {
    command git --git-dir="$dotfiles_dir" --work-tree="$HOME" "$@"
}

mkdir -p "$backup_dir"
if dot checkout; then
    printf '\n\e[1;32m%s\e[m\n' "Checked out dotfiles."
else
    printf '\n\e[1;32m%s\e[m\n' "Backing up pre-existing dotfiles."
    (
        cd "$HOME"
        dot checkout 2>&1 | awk '/^[[:space:]]+\./ { print $1 }' |
            while IFS= read -r path; do
                mkdir -p "$backup_dir/$(dirname "$path")"
                mv "$path" "$backup_dir/$path"
            done
    )
    dot checkout
fi
dot config status.showUntrackedFiles no
dot pull --ff-only

platform_script="$HOME/.bootstrap/$bootstrap_script"
if [ ! -x "$platform_script" ]; then
    >&2 echo "Platform bootstrap script is missing or not executable: $platform_script"
    exit 1
fi

BOOTSTRAP_DISTRO=$distro
BOOTSTRAP_WSL=$wsl
export BOOTSTRAP_DISTRO BOOTSTRAP_WSL
"$platform_script"

PATH="$HOME/.cargo/bin:$PATH"
export PATH

ssh_dir="$HOME/.ssh"
history_file="$HOME/.history"
encrypted_history="$HOME/.history.age"

mkdir -p "$ssh_dir"
if [ ! -s "$history_file" ]; then
    history_tmp=$(mktemp "$HOME/.history.XXXXXX")
    if ! age-plugin-yubikey --identity |
        age -d -i - -o "$history_tmp" "$encrypted_history"; then
        rm -f "$history_tmp"
        exit 1
    fi
    mv "$history_tmp" "$history_file"
fi
touch "$ssh_dir/known_hosts"
touch "$ssh_dir/allowed_signers"
touch "$ssh_dir/authorized_keys"
touch "$ssh_dir/config"
chmod 600 "$history_file"
chmod 700 "$ssh_dir"
chmod 600 "$ssh_dir/known_hosts"
chmod 600 "$ssh_dir/allowed_signers"
chmod 600 "$ssh_dir/authorized_keys"
chmod 600 "$ssh_dir/config"
