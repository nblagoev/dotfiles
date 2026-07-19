#!/usr/bin/env bash

set -euo pipefail

antidote_dir="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"
tpm_dir="$HOME/.tmux/plugins/tpm"

sudo dnf install -y \
    @development-tools \
    age \
    age-plugin-yubikey \
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
    ctop \
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
    hurl \
    hyperfine \
    inetutils \
    ipcalc \
    iperf3 \
    jaq \
    jq \
    lazygit \
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
    pkgconf-pkg-config \
    qrencode \
    rclone \
    ripgrep \
    rustup \
    sd \
    sslscan \
    starship \
    tmux \
    trash-cli \
    tree-sitter-cli \
    ttfautohint \
    tzdata \
    uv \
    watch \
    wget \
    xxh \
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
rustup toolchain install nightly
rustup default nightly
rustup component add rust-analyzer

export PATH="$HOME/.cargo/bin:$HOME/go/bin:$PATH"

go install github.com/bensadeh/circumflex/cmd/clx@v4.5.0
go install mvdan.cc/gofumpt@v0.10.0
cargo install --locked --version 0.15.9 television
uv tool install --reinstall --python 3.13 'posting==2.10.0'

zsh_path=$(command -v zsh)
if [ "${SHELL:-}" != "$zsh_path" ]; then
    printf 'Changing login shell to %s\n' "$zsh_path"
    chsh -s "$zsh_path"
fi
