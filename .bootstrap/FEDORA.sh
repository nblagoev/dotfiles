#!/usr/bin/env bash

set -euo pipefail

antidote_dir="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"
tpm_dir="$HOME/.tmux/plugins/tpm"

sudo dnf install -y \
    @development-tools \
    age \
    asciiquarium \
    bat \
    btop \
    cbonsai \
    cfssl \
    cloc \
    cmake \
    cmatrix \
    coreutils \
    croc \
    crudini \
    curl \
    difftastic \
    direnv \
    dos2unix \
    eza \
    fastfetch \
    fd-find \
    fzf \
    gh \
    git \
    glow \
    go \
    gum \
    hugo \
    hyperfine \
    ipcalc \
    iperf3 \
    jq \
    libtiff \
    lnav \
    minisign \
    navi \
    neovim \
    newsboat \
    nmap \
    nodejs \
    openssh-clients \
    openssl-devel \
    pinentry \
    pcsc-lite \
    pcsc-lite-ccid \
    pcsc-lite-devel \
    pkgconf-pkg-config \
    qrencode \
    rclone \
    ripgrep \
    rustup \
    sslscan \
    tmux \
    trash-cli \
    tree-sitter-cli \
    ttfautohint \
    tzdata \
    uv \
    watch \
    wl-clipboard \
    wget \
    yubikey-manager \
    yt-dlp \
    z3 \
    zoxide \
    zsh \
    zxing-cpp

# Terraform
sudo dnf install -y dnf-plugins-core
if [ ! -f /etc/yum.repos.d/hashicorp.repo ]; then
    sudo dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
fi
sudo dnf install -y terraform

# WSL
if [ "$BOOTSTRAP_WSL" = true ]; then
    sudo crudini --set /etc/wsl.conf network hostname "$BOOTSTRAP_DISTRO"
    sudo crudini --set /etc/wsl.conf network generateHosts false

    if [ "$(cat /proc/1/comm)" = systemd ]; then
        binfmt_conf=/etc/binfmt.d/wsl.conf
        binfmt_rule=':WSLInterop:M::MZ::/init:PF'
        binfmt_tmp=$(mktemp)

        printf '%s\n' "$binfmt_rule" > "$binfmt_tmp"

        if ! sudo test -f "$binfmt_conf" ||
            ! sudo cmp -s "$binfmt_tmp" "$binfmt_conf" ||
            [ "$(sudo stat -c '%U:%G:%a' "$binfmt_conf")" != root:root:644 ]; then
            sudo install -o root -g root -m 644 "$binfmt_tmp" "$binfmt_conf"

            if ! sudo systemctl restart systemd-binfmt.service; then
                >&2 printf '%s\n' 'WSLInterop rule was saved; restart WSL to activate it.'
            fi
        fi

        rm "$binfmt_tmp"
    fi
fi

# Antidote
if [ ! -d "$antidote_dir/.git" ]; then
    git clone --branch v2.1.0 --depth 1 https://github.com/mattmc3/antidote.git "$antidote_dir"
fi

# TPM
if [ ! -d "$tpm_dir/.git" ]; then
    git clone https://github.com/tmux-plugins/tpm.git "$tpm_dir"
    git -C "$tpm_dir" checkout 99469c4a9b1ccf77fade25842dc7bafbc8ce9946
fi

# Rustup
export PATH="$HOME/.cargo/bin:$HOME/go/bin:$PATH"

rustup toolchain install stable
rustup default stable
rustup component add rust-analyzer

go install github.com/bensadeh/circumflex/cmd/clx@v4.5.0
go install github.com/bcicen/ctop@v0.7.7
go install mvdan.cc/gofumpt@v0.10.0
cargo install --locked age-plugin-yubikey
cargo install --locked jaq
cargo install --locked sd
cargo install --locked starship
cargo install --locked --version 0.15.9 television
uv tool install --reinstall --python 3.13 'posting==2.10.0'

zsh_path=$(command -v zsh)
if [ "${SHELL:-}" != "$zsh_path" ]; then
    printf 'Changing login shell to %s\n' "$zsh_path"
    chsh -s "$zsh_path"
fi
