#!/usr/bin/env bash

set -euo pipefail

# Requires: fontforge, gh, npm, and unzip.
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
build_dir=$(mktemp -d "${TMPDIR:-/tmp}/iosevka.XXXXXX")
repo_dir="$build_dir/Iosevka"
output_dir="$script_dir/TTF"
nerdfont_output_dir="$script_dir/TTF-NerdFont"

trap 'rm -rf "$build_dir"' EXIT

git clone --depth 1 https://github.com/be5invis/Iosevka.git "$repo_dir"
cp "$script_dir/private-build-plans.toml" "$repo_dir/private-build-plans.toml"

cd "$repo_dir"
npm install
npm run build -- --jCmd=8 ttf::IosevkaCustom

mkdir -p "$output_dir"
cp "$repo_dir"/dist/IosevkaCustom/TTF/*.ttf "$output_dir"

gh release download --repo ryanoasis/nerd-fonts \
    --pattern FontPatcher.zip \
    --dir "$build_dir"
unzip -q "$build_dir/FontPatcher.zip" -d "$build_dir"

mkdir -p "$nerdfont_output_dir"
find "$repo_dir/dist/IosevkaCustom/TTF" -type f -name '*.ttf' -print0 |
    while IFS= read -r -d '' font; do
        fontforge -script "$build_dir/font-patcher" "$font" \
            --complete --mono --outputdir "$nerdfont_output_dir"
    done
