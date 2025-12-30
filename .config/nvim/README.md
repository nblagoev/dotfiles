# Neovim Configuration


<details>
<summary>A list of frequently-used mappings:</summary>

<br>

- Leader key: `<space>`
- Open the file picker: `<C-space>` (Snacks picker)
- Open another file picker (Fzf-Lua): `<space>ff`
- Close (delete) current buffer: `<space>x`
- Grep across project (Fzf-Lua): `<space>r` in normal or visual mode
- Quit: `<space>qq`
- Force quit: `<space>qQ`
- Save buffer: `<C-S>` in both normal and insert modes
- Save without formatting: `<space>w`
- File tree view:
    - Nvimtree: `<space><space` to show and `,e` to focus.
- File managers:
    - Mini.files: just `-`
    - Yazi: `<space>-`
- Go back to the last visited buffer: `ga` in normal mode
- Go to next buffer: `L`
- Go to previous buffer: `H`
- Open the list of opened buffers (Telescope): `s` in normal mode, `s` to close the list, `j`, `k` to select, and `l` to open selection.
- Toggle horizontal terminal: `<A-\>`
- Toggle vertical terminal: `<C-\>`
- Go from terminal to normal buffer: `<C-T>`. Press again to go from buffer to terminal
- Go to the next window (skipping Neo-tree and Nvimtree): `<C-T>`
- Use `<C-L>` in normal mode (and in insert mode if no completion is being shown) to move the view around the cursor to both center and top. That is, both `zz` and `zt` with just one keybinding
- Toggle maximize window (including a Terminal buffer): `<A-,>`
- Toggle extra information in the statusline: `<space>ti`
- Toggle line wrap: `<space>tw`
- Toggle spell check: `<space>tS`
- Different fold levels: `z1`, `z2`, `z0`. Check more in `lua/config/mappings.lua`
- Git:
    - Check status: `<space>gs`
    - Open Neogit: `<space>gn`
    - Open Lazygit: `<space>gl`
    - Open Vim-Fugitive: `<space>gi`
    - Stage hunk or selection in current buffer: `<space>hs`, or `<space>hS` to stage all changes in the current buffer. Check other mappings under `<space>h`.
- Completions and snippets (LuaSnip):
    - Select next completion suggestion: `<Tab>`
    - Select previous completion suggestion: `<S-Tab>`
    - Confirm completion or snippet suggestion: `<C-L>`
    - Jump to next snippet placeholder: `<C-J>` in insert and selection mode
    - Jump to previous snippet placeholder: `<C-K>` in insert and selection mode

**Note**: although the system clipboard is enabled, motion mappings such as `d`, `c`, `x`, etc., do not copy to the clipboard (ala easy-clip plugin). That is, if you select something and use `d`, that text is deleted and sent to the 'black hole register'. If you want to delete some text to paste it somewhere else, use `m` instead (use `gm` for adding a mark). Take a look at the "Replace the easy-clip plugin" section in `lua/config/mappings.lua`.

</details>
