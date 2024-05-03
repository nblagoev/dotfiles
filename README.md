# Install
```
curl -Lks https://github.com/nblagoev/dotfiles/raw/main/bootstrap.sh | /bin/bash
```
# Custom key bindings

### Zsh
| Binding     | Description |
| ----------- | ----------- |
| `CTRL + o`  | Search current directory with FZF and launch editor with results. Tab to select multiple. |
| `CTRL + r`  | History search using fzf. |
| `CTRL + s`  | Prepend `sudo` to the prompt and move the cursor back to the end of the prompt. |
| `CTRL + b`  | Use FZF to show git branches  |
| `OPT + c`   | Use FZF to cd into a subdir of the current path |
| `r <val>`   | Search current directory with ripgrep for files containing `<val>`, filter with FZF and launch editor with results. Tab to select multiple. |


### Tmux
| Binding        | Description |
| -------------- | ----------- |
| `C-a`          | tmux prefix |
| `C-a F`        | Launch tmux-fzf |
| `C-a ?`        | Show tmux keybindings |
| `C-a +`        | Zoom pane |
| `C-a r`        | Rename window |
| `C-a R`        | Rename session |
| `C-a x`        | Kill window |
| `C-a X`        | Kill session |
| `C-a d`        | Detach |
| `C-a D`        | Detach others |
| `C-a <,>`      | Move window left/right |
| `C-a {,}`      | Swap pane left/right |
| `C-a [,]`      | Select left/right window |
| `C-a /,-`      | Split vertically/horizontally |
| `C-a C-e`      | Edit tmux config |
| `C-a C-r`      | Reload tmux config |
| `C-a C-y`      | Sync panes |
| `C-a C-u`      | Unite (merge) with another session |
| `C-a C-x`      | Kill all other windows |
| `C-n`          | New window |
| `M-arrows`     | Alt/Opt + arrows to move between panes |
| `M-S-arrows`   | Alt/Opt + Shift + arrows to resize panes |
| `C-left,right` | Ctrl + left/right arrows to move between windows |

### Helix
| Binding        | Description |
| -------------- | ----------- |
| `space + F`    | Open file with fzf. Use `ALT+ENTER` to open in background |
| `space + E`    | Open file with yazi (tmux popup) |
| `space + e`    | Open file with yazi (tmux pane) |
