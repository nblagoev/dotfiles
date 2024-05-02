# Install
```
curl -Lks https://github.com/nblagoev/dotfiles/raw/main/bootstrap.sh | /bin/bash
```
# Custom bindings

| Binding        | Context      | Description                                                                                                                                    |
| -------------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `CTRL + o`     | bash/zsh     | Search current directory with FZF and launch editor with results. Tab to select multiple.                                                      |
| `r <string>`   | bash/zsh     | Search current directory with ripgrep for files containing `<string>`, filter with FZF and launch editor with results. Tab to select multiple. |
| `CTRL + r`     | bash/zsh     | History search using fzf.                                                                                                                      |
| `CTRL + s`     | bash/zsh     | Prepend `sudo` to the prompt and move the cursor back to the end of the prompt.                                                                |
| `OPT + c`      | bash/zsh     | Use FZF to cd into a subdir of the current path                                                                                                |
| `CTRL + b`     | bash/zsh     | Use FZF to show git branches                                                                                                                   |
| `CTRL + a`     | tmux         | tmux prefix                                                                                                                                    |
| `prefix + F`   | tmux         | Launch tmux-fzf                                                                                                                                |
| `prefix + ?`   | tmux         | Show tmux keybindings |
| `space + F`    | helix        | Open file with fzf      |
| `ALT+ENTER`    | helix        | Open the selected file in background, without closing the FZF selector |

