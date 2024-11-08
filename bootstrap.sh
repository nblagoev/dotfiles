#!/bin/sh

ORIGIN=https://github.com/nblagoev/dotfiles.git

# exit on error
set -e

# Supported platforms
MACOS_ARM64=MACOS_ARM64
MACOS_AMD64=MACOS_AMD64
UBUNTU_AMD64=UBUNTU_AMD64
RASPBIAN_ARMV5=RASPBIAN_ARMV5

# authorise sudo early on
if ! sudo -n echo 2>/dev/null; then
    echo "Please enter sudo password. Sudo session will be kept alive until this script exits."
    # sudo -v is technically correct but asks for a non-existent password on fresh AWS Ubuntu AMIs
    sudo echo -n
fi

# sudo keepalive. This will keep the sudo watchdog fed until this script exits.
# This works by poking the parent process to see if it's still alive.
while true; do sudo -n true; sleep 15; kill -0 "$$" || exit; done 2>/dev/null &

printf '\n\e[1;32m%s\e[m\n' "OS detection..."

if uname | grep -q Linux; then
    if ! command -v hostnamectl >/dev/null; then
        >&2 echo "Could not determine OS"
        exit 1
    fi

    if sudo hostnamectl | grep -q "Ubuntu" && getconf LONG_BIT | grep -q 64; then
        PLATFORM=$UBUNTU_AMD64
    elif sudo hostnamectl | grep -q "Raspbian" && getconf LONG_BIT | grep -q 32; then
        PLATFORM=$RASPBIAN_ARMV5
    else
        >&2 echo "Unsupported OS"
        exit 1
    fi
elif uname | grep -q Darwin && getconf LONG_BIT | grep -q 64; then
    if uname -m | grep -q arm; then
        PLATFORM=$MACOS_ARM64
    else
        PLATFORM=$MACOS_AMD64
    fi
else
    >&2 echo "Unsupported OS"
    exit 1
fi

echo $PLATFORM

printf '\n\e[1;32m%s\e[m\n' "Bootstrapping..."

# make sure git/sudo is installed
case $PLATFORM in
    $MACOS_AMD64)
        # triggers install of xcode cli tools or effectively does nothing
        git --version
        ;;
    $UBUNTU_AMD64)
        sudo apt-get -y update
        sudo apt-get -y install git
        ;;
    $RASPBIAN_ARMV5)
        sudo apt-get -y update
        sudo apt-get -y install git
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

source ./.bootstrap/"${PLATFORM}".sh

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
