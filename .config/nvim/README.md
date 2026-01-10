## Navigation

| Key | Mode(s) | Description |
| --- | --- | --- |
| `j` / `k` | `n` | Move down/up, respects wrapped lines |
| `gk`/`gh`/`gl`| `n`, `v`, `o` | Go to start / first char / end of line |
| `<C-d>`/`<C-u>`| `n` | Scroll half page down/up and center view |
| `n` / `N` | `n` | Center view on next/previous search result |
| `]]` / `[[` | `n` | Go to next/previous reference |
| `<M-u/i/o/p>` | `n` | Navigate to Harpoon file 1/2/3/4 |
| `ga` | `n` | Go to last visited buffer |
| `<S-l>`/`<S-h>`| `n` | Go to next/previous buffer |

## Editing

| Key | Mode(s) | Description |
| --- | --- | --- |
| `jj`, `jk` | `i`, `c`, `t` | Exit to Normal mode |
| `<` / `>` | `v` | Indent/un-indent and keep selection |
| `<C-c>` | `n`, `x` | Toggle line comment |
| `<C-b>` | `n`, `x` | Toggle block comment |
| `gcy` | `n` | Duplicate current line and comment the original |
| `gy` | `v` | Duplicate and comment visual selection |
| `,t` | `n` | Transpose/swap characters |
| `,w` | `n` | Transpose/swap words |
| `,A` | `n` | Select the entire file |
| `ga` | `x` | Start EasyAlign |
| `<leader>pt` | `x` | Align Markdown Table by `|` |
| `<leader>pa` | `v` | Align by `=` |
| `p` | `v` | Paste over selection without yanking it |
| `<leader>p`/`P`| `n, v, o` | Paste from system clipboard |
| `<leader>y`/`Y`| `n, v, o` | Yank to system clipboard |
| `<leader>m` | (all) | Cut to system clipboard |
| `<M-h/j/k/l>` | `n`, `v` | Move selection/line |
| `S`/`ds`/`cs` | `n`, `v` | Add/Delete/Change surrounding |
| `<up>`/`<down>`| `n`, `x` | Add cursor above/below |
| `<C-N>`/`/n`| `n`, `x` | Add cursor on next match |
| `<leader>/...`| `n`, `x` | Various multicursor actions (toggle, skip, etc.) |

## Searching & Replacing

| Key | Mode(s) | Description |
| --- | --- | --- |
| `*` / `#` | `n`, `v` | Search for word under cursor (or selection) and stay |
| `<leader>tr` | `n` | Clear search highlighting and redraw screen |
| `<esc>` | `n` | Clear search highlighting |
| `<leader>R` | `n`, `v` | Substitute last search pattern |
| `<leader>X` | `n`, `v` | Substitute word under cursor / selection in the whole file |
| `<leader>ff` | `n` | Find Files |
| `<C-Space>` | `n` | Find Files |
| `<leader>fg` | `n` | Find Git Files |
| `<leader>fr` | `n` | Recent Files |
| `<leader>sg` | `n` | Grep Project |
| `<leader>sw` | `n`, `x`| Grep word under cursor/selection |
| `<leader>s...`| `n` | Various search pickers (history, commands, etc.) |

## File & Buffer Management

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>w` | `n` | Save file without formatting |
| `<leader>x` | `n` | Close/delete current buffer |
| `<leader>bd` | `n` | Delete buffer and window |
| `<leader>bD` | `n` | Force delete buffer |
| `<leader>bw` | `n` | Wipeout buffer |
| `<leader>bo` | `n` | Close all other buffers |
| `-` | `n` | Toggle file explorer |
| `Y`/`X`/`F` | `n` | In explorer: Copy Path / Make executable / Preview |
| `<leader>hh` | `n` | Toggle Harpoon quick menu |
| `<leader>ha` | `n` | Add file to Harpoon |
| `<leader>qs` | `n` | Load Session |

## Window & Tab Management

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<C-h/j/k/l>` | `n` | Navigate windows left/down/up/right |
| `<C-t>` | `n`, `t` | Smartly cycle to the next window |
| `<C-Up/Down>` | `n` | Resize window height |
| `<C-Left/Right>`| `n` | Resize window width |
| `<A-,>` | `n`, `t` | Maximize/restore window size |
| `<leader>qq` | `n` | Quit all windows |
| `<leader>qw` | `n` | Quit current window |
| `<leader>qQ` | `n` | Force quit current window |
| `<leader><tab>...` | `n` | Mappings for Tab management (new, close, next, etc.) |
| `<leader>zz` | `n` | Zoom Window |

## Code Completion & Snippets

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<C-Space>` | `i`, `c` | Trigger completion |
| `<C-l>` | `i`, `s` | Confirm selection |
| `<Tab>`/`<S-Tab>`| `i`, `s` | Select next/previous item |
| `<C-b>`/`<C-f>` | `i`, `c` | Scroll docs up/down |
| `<C-e>` | | Hide completion menu (blink.cmp) |
| `<C-y>` | | Select and accept completion (blink.cmp) |
| `<c-j>`/`<c-k>` | `i`, `s` | Jump forward/backward in snippet |
| `<c-l>`/`<c-h>` | `i` | Go to next/previous choice in snippet |
| `;cc` / `;cf` | `i`, `v` | Surround with `{}` / callback function |
| `;cm` / `;cp` | `v` | Surround with fold comment / `print()` |

## Language Server Protocol (LSP) & Diagnostics

| Key | Mode(s) | Description |
| --- | --- | --- |
| `gd` | `n` | Go to Definition |
| `<leader>gr` | `n` | Find References |
| `gy` | `n` | Go to Type Definition |
| `<leader>ls` | `n` | Document Symbols |
| `]d` / `[d` | `n` | Next / Previous diagnostic |
| `]e` / `[e` | `n` | Next / Previous error diagnostic |
| `]w` / `[w` | `n` | Next / Previous warning diagnostic |
| `<leader>cd` | `n` | Show diagnostics for the current line in a float |
| `<C-P>` | `n` | Peek Definition |
| `,d` | `n` | Peek Diagnostics |
| `,f` | `n` | Peek Functions |

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
| `<leader>gs` | `n` | Git Status |
| `<leader>gc` | `n` | Git Log |

## Debugging

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>db` | `n` | Toggle Breakpoint |
| `<leader>dc` | `n` | Continue |
| `<leader>do`/`di`| `n` | Step Over / Step Into |
| `<leader>dr` | `n` | Open REPL |
| `<leader>du` | `n` | Toggle DAP UI |
| `<leader>ds` | `v` | Debug Python selection |

## AI & Code Assistance

| Key | Mode(s) | Description |
| --- | --- | --- |
| `go`, `<leader>jc` | `n`, `v` | Toggle CodeCompanion Chat |
| `<leader>jl` | `n`, `v` | CodeCompanion Inline Assistant |
| `<leader>jA` | `n`, `v` | CodeCompanion Actions |
| `<leader>js` | `v` | Add selection to CodeCompanion |
| `<leader>jg` | `n`, `v` | GPTModelsCode |
| `<leader>jG` | `n`, `v` | GPTModelsChat |
| `<leader>cx` | `n` | Toggle Codeium |
| `<C-c>` | `i` | Accept Codeium suggestion |
| `<C-n>`/`<C-p>`| `i` | Next / Previous Codeium suggestion |
| `<leader>cp` | `n` | Toggle Copilot |

## Note Taking

| Key | Mode(s) | Description |
| --- | --- | --- |
| `gf` | `n` | Follow link under cursor |
| `<leader>tt` | `n` | Toggle checkbox |

## UI & Toggles

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>tl` | `n` | Toggle line number visibility options |
| `<leader>tw` | `n` | Toggle line wrap |
| `z0` / `z1`... | `n` | Set code fold level |
| `<leader>f...`| `n` | Set fold method (indent, marker, treesitter) |
| `<leader>nl` | `n` | Show last message |
| `<leader>nh` | `n` | Show message history |
| `<leader>nx` | `n` | Dismiss all messages |
| `<c-f>`/`<c-b>`| `i,n,s` | Scroll forward/backward in UI view |
| `,p` | | Pick color |
| `,c` | | Toggle colorizer |

## Miscellaneous

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>cf` | `n` | Format file |
| `<Space>D` | `x` | Diff visual selection against clipboard |
| `<leader>pd` | `n, v, o`| Pick dotfiles (custom picker) |
| `<space>y` | `n` | Yank current file path to clipboard |

## Which-Key Prefixes

These are prefixes that open a menu of subsequent key bindings.

| Key | Mode(s) | Group Name |
| --- | --- | --- |
| `<leader>` | `n`, `v`| Main Leader Menu |
| `<leader>b` | `n` | Buffer |
| `<leader>c` | `n`, `v`| Coding |
| `<leader>d` | `n`, `v`| Debug |
| `<leader>f` | `n` | File/Fold |
| `<leader>g` | `n` | Git/Glance |
| `<leader>h` | `n`, `v`| Gitsigns/Harpoon |
| `<leader>j` | `n`, `v`| AI |
| `<leader>l` | `n`, `v`| LSP |
| `<leader>o` | `n`, `v`| Open |
| `<leader>q` | `n` | Quit |
| `<leader>s` | `n`, `v`| Search/Replace |
| `<leader>t` | `n` | Toggle |
