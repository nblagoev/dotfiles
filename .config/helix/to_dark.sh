
#!/bin/bash

# Set file path
file_path="$HOME/.config/helix/config.toml"

# Replace theme value in first line of file with 'data'
sed -i '' '1s/theme = .*/theme = "catppuccin_mocha"/' $file_path

pkill -USR1 hx

