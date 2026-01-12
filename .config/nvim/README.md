## Navigation

| Key | Mode(s) | Description |
| --- | --- | --- |
| `j` / `k` | `n` | Move down/up, respects wrapped lines |
| `gk`/`gh`/`gl`| `n`, `v`, `o` | Go to start / first char / end of line |
| `<C-d>`/`<C-u>`| `n` | Scroll half page down/up and center view |
| `n` / `N` | `n` | Center view on next/previous search result |
| `]]` / `[[` | `n` | Go to next/previous reference (vim-illuminate) |
| `<M-u/i/o/p>` | `n` | Navigate to Harpoon file 1/2/3/4 |
| `ga` | `n` | Go to (reopen) last visited buffer |
| `<S-l>`/`<S-h>`| `n` | Go to next/previous buffer |
| `<C-h/j/k/l>` | `n` | Navigate windows left/down/up/right |
| `<C-t>` | `n`, `t` | Smartly cycle to the next window |
| `]d` / `[d` | `n` | Next / Previous diagnostic |
| `]e` / `[e` | `n` | Next / Previous error diagnostic |
| `]w` / `[w` | `n` | Next / Previous warning diagnostic |
| `gd` / `gD` | `n` | Go to Definition / Declaration (Snacks) |
| `gy` | `n` | Go to Type Definition (Snacks) |
| `gw` / `gt` | `n`, `x`, `o` | Jump with Flash / Flash Treesitter |
| `<C-z>` | `n`, `i`, `v` | Move cursor around with virtual text |

## Editing

| Key | Mode(s) | Description |
| --- | --- | --- |
| `jj`, `jk` | `i`, `c`, `t` | Exit to Normal mode |
| `U` | `n` | Redo |
| `<` / `>` | `v` | Indent/un-indent and keep selection |
| `<C-c>` / `<C-b>` | `n`, `x` | Toggle line/block comment |
| `gcy` | `n` | Duplicate current line and comment the original |
| `gy` | `v` | Duplicate and comment visual selection |
| `,T` / `,W` | `n` | Transpose/swap characters/words |
| `,A` | `n` | Select the entire file |
| `,S` | `n` | Split/Join block (mini.splitjoin) |
| `<leader>lj` | `n` | Split/Join block (treesj) |
| `p` | `v` | Paste over selection without yanking it |
| `,p`/`,P`| `n, v, o` | Paste from system clipboard |
| `,y`/`,Y`| `n, v, o` | Yank to system clipboard |
| `,m` | (all) | Cut to system clipboard |
| `d`/`x`/`c`... | `n`, `v` | All delete/change/cut ops use the black-hole register |
| `<M-h/j/k/l>` | `n`, `v` | Move selection/line |
| `S`/`ds`/`cs` | `n`, `v` | Add/Delete/Change surrounding (mini.surround) |
| `<up>`/`<down>`| `n`, `x` | Add cursor above/below (multicursor) |
| `<C-N>`/`/n`| `n`, `x` | Add cursor on next match (multicursor) |
| `<leader>/...`| `n`, `x` | Various multicursor actions (toggle, skip, etc.) |
| `,w` | `n`, `v` | Trim trailing whitespace |
| `,h` | `v` | Convert HEX color to Uppercase |

## Searching & Replacing

| Key | Mode(s) | Description |
| --- | --- | --- |
| `*` / `#` | `n`, `v` | Search for word under cursor (or selection) and stay |
| `<leader>tr` | `n` | Clear search highlighting and redraw screen |
| `<esc>` | `n` | Clear search highlighting |
| `,R` | `n`, `v` | Substitute last search pattern |
| `,X` | `n`, `v` | Substitute word under cursor / selection in the whole file |
| `<leader>ff` | `n` | Find Files (Snacks) |
| `<C-Space>` | `n` | Find Files (Snacks) |
| `<leader>fg` | `n` | Find Git Files (Snacks) |
| `<leader>fr` | `n` | Recent Files (Snacks) |
| `<leader>sg` | `n` | Grep Project (Snacks) |
| `<leader>sw` | `n`, `x`| Grep word under cursor/selection (Snacks) |
| `<leader>s...`| `n` | Various search pickers (history, commands, etc.) (Snacks) |

## File & Buffer Management

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>w` | `n` | Save file without formatting |
| `<leader>bx` | `n` | Close/delete current buffer |
| `<leader>bd` | `n` | Delete buffer and window |
| `<leader>bD` | `n` | Force delete buffer |
| `<leader>bw` | `n` | Wipeout buffer |
| `<leader>bo` | `n` | Close all other buffers |
| `-` | `n` | Toggle file explorer (mini.files) |
| `Y`/`X`/`F` | `n` | In explorer: Copy Path / Make executable / Preview |
| `<leader>hh` | `n` | Toggle Harpoon quick menu |
| `<leader>ha` | `n` | Add file to Harpoon |
| `<leader>qs` | `n` | Load Session |
| `<leader>oy` | `n` | Yank current working directory |
| `<leader>og` | `n`, `v` | Open Github Repo from selection/word |
| `<leader>ov` | `n`, `v` | Quick Look File Preview |
| `<leader>fd` | `n` | Pick and open a dotfile |

## Window & Tab Management

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<C-Up/Down>` | `n` | Resize window height |
| `<C-Left/Right>`| `n` | Resize window width |
| `<A-,>` | `n`, `t` | Maximize/restore window size |
| `<leader>qq` | `n` | Quit all windows |
| `<leader>qw` | `n` | Quit current window |
| `<leader>qQ` | `n` | Force quit current window |
| `<leader><tab>...` | `n` | Mappings for Tab management (new, close, next, etc.) |
| `<leader>tz` | `n` | Zoom Window (Snacks) |

## Code Completion & Snippets

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<C-Space>` | `i`, `c` | Trigger completion (nvim-cmp) |
| `<C-l>` | `i`, `s` | Confirm selection (nvim-cmp) |
| `<Tab>`/`<S-Tab>`| `i`, `s` | Select next/previous item (nvim-cmp) |
| `<C-b>`/`<C-f>` | `i`, `c` | Scroll docs up/down (nvim-cmp) |
| `<c-j>`/`<c-k>` | `i`, `s` | Jump forward/backward in snippet (luasnip) |
| `<c-l>`/`<c-h>` | `i` | Go to next/previous choice in snippet (luasnip) |
| `;cc` / `;cf` | `i`, `v` | Surround with `{}` / callback function (luasnip) |
| `;cm` / `;cp` | `v` | Surround with fold comment / `print()` (luasnip) |

## LSP & Diagnostics

| Key | Mode(s) | Description |
| --- | --- | --- |
| `K` | `n` | Hover documentation |
| `gK` | `n` | Signature Help |
| `<c-p>` | `i` | Signature Help |
| `<leader>lr` | `n` | Rename symbol |
| `<leader>la` | `n`, `v` | Code Action |
| `<leader>ll` | `n`, `v` | Run Codelens |
| `<leader>lL` | `n` | Refresh & Display Codelens |
| `<leader>lx` | `n` | Show diagnostics for the current line in a float |
| `<leader>gr` | `n` | Find References (Snacks) |
| `<leader>ls` | `n` | Document Symbols (Snacks) |
| `gs` / `gS` | `n` | Buffer / Watchtower Symbols (Namu) |
| `<leader>lS` | `n` | Workspace Symbols (Namu) |
| `<leader>ld`/`lD`| `n` | Buffer / Workspace Diagnostics (Namu) |
| `<leader>lp` | `n` | Peek definition (custom) |

## Git Integration

| Key | Mode(s) | Description |
| --- | --- | --- |
| `]c` / `[c` | `n` | Go to next/previous hunk |
| `<leader>hs` | `n`, `v` | Stage hunk |
| `<leader>hr` | `n`, `v` | Reset hunk |
| `<leader>hS` | `n` | Stage buffer |
| `<leader>hR` | `n` | Reset buffer |
| `<leader>hp` | `n` | Preview hunk |
| `<leader>gb` | `n` | Blame line |
| `<leader>tb` | `n` | Toggle current line blame |
| `<leader>gd` | `n` | Diff this |
| `ih` | `o`, `x` | Select hunk (text object) |
| `<leader>gs` | `n` | Git Status (Snacks) |
| `<leader>gc` | `n` | Git Log (Snacks) |

## Debugging

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>db` | `n` | Toggle Breakpoint |
| `<leader>dc` | `n` | Continue |
| `<leader>do`/`di`| `n` | Step Over / Step Into |
| `<leader>dr` | `n` | Open REPL |
| `<leader>du` | `n` | Toggle DAP UI |
| `<leader>ds` | `v` | Debug Python selection |
| `<leader>dR` | `n` | Show Rust debuggables |

## AI & Code Assistance

| Key | Mode(s) | Description |
| --- | --- | --- |
| `go`, `<leader>jc` | `n`, `v` | Toggle CodeCompanion Chat |
| `<leader>jl` | `n`, `v` | CodeCompanion Inline Assistant |
| `<leader>jA` | `n`, `v` | CodeCompanion Actions |
| `<leader>js` | `v` | Add selection to CodeCompanion |
| `<leader>tC` | `n` | Toggle Codeium |
| `<leader>tP` | `n` | Toggle Copilot |
| `<C-c>` | `i` | Accept suggestion (Codeium/Copilot) |
| `<C-n>`/`<C-p>`| `i` | Next / Previous suggestion (Codeium) |

## Note Taking & Markdown

| Key | Mode(s) | Description |
| --- | --- | --- |
| `gf` | `n` | Follow link under cursor (Obsidian) |
| `<leader>tt` | `n` | Toggle checkbox (Obsidian) |
| `<leader>tp` | `n` | Toggle markdown preview |
| `<leader>ga` | `n` | Follow internal markdown link |
| `ga` | `x` | Start EasyAlign |
| `<leader>pt` | `x` | Align Markdown Table by `|` |
| `<leader>pa` | `v` | Align by `=` |

## UI & Toggles

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>tl` | `n` | Toggle line number visibility options |
| `<leader>tw` | `n` | Toggle line wrap |
| `<leader>th` | `n` | Toggle inlay hints |
| `<leader>tD` | `n` | Toggle diagnostics |
| `<leader>td` | `n` | Toggle diagnostic virtual lines |
| `<leader>tx` | `n` | Toggle Treesitter Context |
| `z0` / `z1`... | `n` | Set code fold level |
| `<leader>f...`| `n` | Set fold method (indent, marker, treesitter) |
| `<leader>nl` | `n` | Show last message (Noice) |
| `<leader>nh` | `n` | Show message history (Noice) |
| `<leader>nx` | `n` | Dismiss all messages (Noice) |
| `<c-f>`/`<c-b>`| `i,n,s` | Scroll forward/backward in Noice view |
| `<leader>ti` | `n` | Toggle more info in statusline |
| `<leader>tS` | `n` | Toggle spell checking |
| `<leader>tc` | `n` | Toggle colorizer |

## Miscellaneous

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>lf` | `n` | Format file (conform) |
| `<Space>D` | `x` | Diff visual selection against clipboard |
| `gi...` | `n`, `x` | Convert text case (e.g., `git` for Title Case) |
| `<leader>Li` / `<leader>Lp` | `n`, `v` | Inspect / Print Lua code |
| `<leader>ol` | `n` | Open Lazy dashboard |
| `<leader>om` | `n` | Open Mason |

## Which-Key Prefixes

These are prefixes that open a menu of subsequent key bindings.

| Key | Mode(s) | Group Name |
| --- | --- | --- |
| `<leader>` | `n`, `v`| Main Leader Menu |
| `<leader>b` | `n` | Buffer |
| `<leader>d` | `n`, `v`| Debug |
| `<leader>f` | `n` | File/Fold |
| `<leader>g` | `n` | Git/Glance |
| `<leader>h` | `n`, `v`| Gitsigns/Harpoon |
| `<leader>j` | `n`, `v`| AI |
| `<leader>l` | `n`, `v`| Language |
| `<leader>L` | `n` | Lua |
| `<leader>n` | `n` | Notifications |
| `<leader>o` | `n`, `v`| Open |
| `<leader>q` | `n` | Quit |
| `<leader>s` | `n`, `v`| Search/Replace |
| `<leader>t` | `n` | Toggle |
| `<leader>/` | `n` | Multicursor |
| `<leader><Tab>` | `n` | Tabs |
| `g` | `n`, `x`| Go |
| `z` | `n`, `x`| Folds / Spelling |
| `[`/`]` | `n` | Brackets / Hunks / Diagnostics |
| `"` | `n`, `x`| Registers |
| `'`/`` ` `` | `n`, `x`| Marks |
| `,` | `n`, `x` | Custom Mappings |