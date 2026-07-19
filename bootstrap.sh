#!/bin/sh

ORIGIN=https://github.com/nblagoev/dotfiles.git

# exit on error
set -e

printf '\n\e[1;32m%s\e[m\n' "OS detection..."

kernel=$(uname -s)
raw_arch=$(uname -m)
arch=
distro=
distro_like=
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
        distro_like=${ID_LIKE:-}
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
                case " $distro_like " in
                    *" fedora "*)
                        platform=fedora
                        bootstrap_script=FEDORA.sh
                        ;;
                    *)
                        platform=unsupported
                        ;;
                esac
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

if [ "$platform" = "fedora" ]; then
    >&2 echo "Fedora is detected, but its package bootstrap has not been added yet."
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

printf '\n\e[1;32m%s\e[m\n' "Bootstrapping..."

# make sure git/sudo is installed
case "$platform" in
    macos)
        # triggers install of xcode cli tools or effectively does nothing
        git --version
        ;;
esac

test ! -d $HOME/.dotfiles && git clone --recurse-submodules --bare $ORIGIN $HOME/.dotfiles
function dot {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
dot checkout

if [ $? = 0 ]; then
  printf '\n\e[1;32m%s\e[m\n' "Checked out dotfiles.";
else
  printf '\n\e[1;32m%s\e[m\n' "Backing up pre-existing dotfiles.";
  dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;

dot checkout
dot config status.showUntrackedFiles no
dot pull --ff-only

source "./.bootstrap/${bootstrap_script}"

mkdir ~/.ssh
touch ~/.history
touch ~/.ssh/known_hosts
touch ~/.ssh/allowed_signers
touch ~/.ssh/authorized_keys
touch ~/.ssh/config
chmod 600 ~/.history
chmod 700 ~/.ssh
chmod 600 ~/.ssh/known_hosts
chmod 600 ~/.ssh/allowed_signers
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/config
