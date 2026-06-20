## Navigation

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<C-d>`/`<C-u>`| `n` | Scroll half page down/up and center view |
| `<C-h/j/k/l>` | `n` | Navigate windows left/down/up/right |
| `<C-t>` | `n`, `t` | Smartly cycle to the next window |
| `<C-z>` | `n`, `i`, `v` | Move cursor around with virtual text |
| `<CR>` / `<BS>` | `n`, `x`, `o` | Select parent / child Tree-sitter node, with LSP selection fallback |
| `<S-l>`/`<S-h>`| `n` | Go to next/previous buffer |
| `]d` / `[d` | `n` | Next / Previous diagnostic |
| `]e` / `[e` | `n` | Next / Previous error diagnostic |
| `]]` / `[[` | `n` | Go to next/previous reference (vim-illuminate) |
| `ga` | `n` | Go to (reopen) last visited buffer |
| `gk`/`gh`/`gl`| `n`, `v`, `o` | Go to start / first char / end of line |
| `gw` / `gt` | `n`, `x`, `o` | Jump with Flash / Flash Treesitter |
| `j` / `k` | `n` | Move down/up, respects wrapped lines |
| `n` / `N` | `n` | Center view on next/previous search result |

## Editing

| Key | Mode(s) | Description |
| --- | --- | --- |
| `,A` | `n` | Select the entire file |
| `,S` | `n` | Split/Join block (mini.splitjoin) |
| `,T` / `,W` | `n` | Transpose/swap characters/words |
| `,a` / `g;` | `n` | Select current line without the trailing newline |
| `,h` | `v` | Convert HEX color to Uppercase |
| `,m` | (all) | Cut to system clipboard |
| `<C-N>` / `<leader>/n` | `n`, `x` | Add cursor on next match (multicursor) |
| `<C-O>` | `i` | Insert line above |
| `<C-b>` / `<C-c>` | `n`, `x` | Toggle line/block comment |
| `<Esc>` | `t` | Exit Terminal mode |
| `<M-h/j/k/l>` | `n`, `v` | Move selection/line (mini.move) |
| `<leader>/A` / `<leader>/N` / `<leader>/S` | `n` | Add all search cursors / add next search cursor / skip search cursor |
| `<leader>/I` | `x` | Insert for each selected line (multicursor) |
| `<leader>/M` / `<leader>/P` | `x` | Match / split cursors by regex (multicursor) |
| `<leader>/l` | `n` | Align cursors (multicursor) |
| `<leader>/s` | `n`, `x` | Skip next match (multicursor) |
| `<leader>/t` / `<leader>/a` | `n`, `x` | Toggle cursor / duplicate cursors (multicursor) |
| `<leader>/v` | `n` | Restore cursors (multicursor) |
| `<leader>x` | `n`, `x` | Delete the active cursor when multicursor is active |
| `<leader>lj` | `n` | Split/Join block (treesj) |
| `<left>` / `<right>` | `n`, `x` | Select previous/next cursor when multicursor is active |
| `<up>`/`<down>`| `n`, `x` | Add cursor above/below (multicursor) |
| `d`/`x`/`c`... | `n`, `v` | All delete/change/cut ops use the black-hole register |
| `gcy` | `n` | Duplicate current line and comment the original |
| `gm` | `n` | Set a mark |
| `gy` | `v` | Duplicate and comment visual selection |
| `J` | `n` | Join lines while preserving cursor position |
| `p` | `v` | Paste over selection without yanking it |
| `S`/`ds`/`cs` | `n`, `v` | Add/Delete/Change surrounding (mini.surround) |
| `U` | `n` | Redo |
| `]<Space>` / `[<Space>` | `n` | Insert blank line below / above |
| `jj`, `jk` | `i`, `c`, `t` | Exit to Normal mode |
| `,p`/`,P`| `n, v, o` | Paste from system clipboard |
| `,w` | `n`, `v` | Trim trailing whitespace |
| `,y`/`,Y`| `n, v, o` | Yank to system clipboard |

## Searching & Replacing

| Key | Mode(s) | Description |
| --- | --- | --- |
| `,R` | `n`, `v` | Substitute last search pattern |
| `,X` | `n`, `v` | Substitute word under cursor / selection in the whole file |
| `*` / `#` | `n`, `v` | Search for word under cursor (or selection) and stay |
| `<C-Space>` | `n` | Find Files (Snacks) |
| `<esc>` | `n` | Clear search highlighting |
| `<leader>'` | `n` | Resume last picker (Snacks) |
| `<leader>ff` | `n` | Find Files (Snacks) |
| `<leader>fb` | `n` | Buffers (Snacks) |
| `<leader>fg` | `n` | Find Git Files (Snacks) |
| `<leader>fr` | `n` | Recent Files (Snacks) |
| `<leader>qp` | `n` | Projects (Snacks) |
| `<leader>s'` | `n` | Registers (Snacks) |
| `<leader>sa` / `<leader>sc` / `<leader>sC` | `n` | Autocmds / Command History / Commands (Snacks) |
| `<leader>sb` | `n` | Buffer Lines (Snacks) |
| `<leader>sB` | `n` | Grep Open Buffers (Snacks) |
| `<leader>sg` | `n` | Grep Project (Snacks) |
| `<leader>sh` / `<leader>sj` / `<leader>sk` | `n` | Help Pages / Jumps / Keymaps (Snacks) |
| `<leader>sM` / `<leader>sm` / `<leader>sR` | `n` | Man Pages / Marks / Resume picker (Snacks) |
| `<leader>sw` | `n`, `x`| Grep word under cursor/selection (Snacks) |
| `<leader>tr` | `n` | Clear search highlighting and redraw screen |
| `<leader>u` | `n` | Undo Tree (Snacks) |
| `g*` / `g#` | `n`, `v` | Search non-exact word under cursor (or selection) and stay |

## File & Buffer Management

| Key | Mode(s) | Description |
| --- | --- | --- |
| `-` | `n` | Toggle file explorer (mini.files) |
| `<C-S-s>` | `n`, `v`, `i`, `s` | Save file without formatting |
| `<C-s>` | `n`, `v`, `i`, `s` | Save file |
| `<C-w>s` / `<C-w>v` | `n` | In mini.files: open target in horizontal / vertical split |
| `<leader>bd` | `n` | Delete buffer and window |
| `<leader>bD` | `n` | Force delete buffer |
| `<leader>bo` | `n` | Close all other buffers |
| `<leader>bw` | `n` | Wipeout buffer |
| `<leader>bx` | `n` | Close/delete current buffer |
| `<leader>e` | `n` | File Explorer (Snacks) |
| `<leader>fd` | `n`, `v`, `o` | Pick and open a dotfile |
| `<leader>og` | `n`, `v` | Open Github Repo from selection/word |
| `<leader>op` | `n` | Reopen previous buffer |
| `<leader>ov` | `n`, `v` | Quick Look File Preview |
| `<leader>oy` | `n` | Yank current working directory |
| `<leader>qs` | `n` | Load Session |
| `<leader>w` | `n` | Save file without formatting |
| `Y`/`X`/`F` | `n` | In mini.files: Copy Path / Make executable / Quick Look preview |

## Window & Tab Management

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<A-,>` | `n`, `t` | Maximize/restore window size |
| `<leader>qq` | `n` | Quit all windows |
| `<leader>qQ` | `n` | Force quit current window |
| `<leader>qR` | `n` | Restart Neovim |
| `<leader>qw` | `n` | Quit current window |
| `<leader><tab>...` | `n` | Mappings for Tab management (new, close, next, etc.) |
| `<C-Left/Right>`| `n` | Resize window width |
| `<C-Up/Down>` | `n` | Resize window height |
| `<leader>tz` | `n` | Zoom Window (Snacks) |

## Code Completion & Snippets

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<C-b>`/`<C-f>` | `i`, `c` | Scroll docs up/down (blink.cmp) |
| `<C-c>` | `i`, `s` | Select active snippet choice (LuaSnip) |
| `<C-e>` | `i`, `c` | Cancel completion (blink.cmp) |
| `<C-k>` | `i`, `c` | Show/hide signature help (blink.cmp) |
| `<C-n>`/`<C-p>` | `i`, `c` | Select next/previous item (blink.cmp) |
| `<C-r>s` | `i` | Insert on-the-fly snippet (LuaSnip) |
| `<C-Space>` | `i`, `c` | Show completion (blink.cmp) |
| `<C-y>` | `i`, `c` | Accept selection (blink.cmp) |
| `<c-j>`/`<c-k>` | `i`, `s` | Jump forward/backward in snippet (luasnip) |
| `<c-l>`/`<c-h>` | `i` | Go to next/previous choice in snippet (luasnip) |
| `;cc` / `;cf` | `i`, `v` | Surround with `{}` / callback function (luasnip) |
| `;cm` / `;cp` | `v` | Surround with fold comment / `print()` (luasnip) |
| `<Tab>`/`<S-Tab>`| `i`, `c` | Select next/previous item (blink.cmp) |
| `<Up>`/`<Down>` | `i`, `c` | Select previous/next item (blink.cmp) |

## LSP & Diagnostics

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<C-F>` / `<C-G>` | `i` | Accept / cycle inline completion |
| `<leader>lA` | `n` | Fix all ESLint / Stylelint errors when that LSP is attached |
| `<leader>lC` | `n`, `x` | Color presentation |
| `<leader>ld` / `<leader>lD` | `n` | Go to Definition / Declaration (Snacks). In non-LSP buffers: Namu diagnostics |
| `<leader>lI` | `n` | Go to Implementation (Snacks) |
| `<leader>lK` | `n` | Signature Help |
| `<leader>lL` | `n` | Refresh & Display Codelens |
| `<leader>lS` | `n` | Workspace Symbols (Namu) |
| `<leader>la` | `n`, `v` | Code Action |
| `<leader>lk` | `n` | Hover documentation |
| `<leader>ll` | `n`, `v` | Run Codelens |
| `<leader>ln` | `n` | Rename symbol |
| `<leader>lp` | `n` | Peek definition (custom) |
| `<leader>lr` | `n` | Find References (Snacks) |
| `<leader>ls` | `n` | Document Symbols (Snacks) |
| `<leader>lx` | `n` | Show diagnostics for the current line in a float |
| `<leader>ly` | `n` | Go to Type Definition (Snacks) |
| `<c-p>` | `i` | Signature Help |
| `gs` / `gS` | `n` | Buffer / Watchtower Symbols (Namu) |

## Git Integration

| Key | Mode(s) | Description |
| --- | --- | --- |
| `]c` / `[c` | `n` | Go to next/previous hunk |
| `<leader>gB` | `n` | Blame line (full) |
| `<leader>gD` | `n` | Diff this (~ last commit) |
| `<leader>gb` | `n` | Blame line |
| `<leader>gc` | `n` | Git Log (Snacks) |
| `<leader>gd` | `n` | Diff this |
| `<leader>gs` | `n` | Git Status (Snacks) |
| `<leader>hR` | `n` | Reset buffer |
| `<leader>hS` | `n` | Stage buffer |
| `<leader>hp` | `n` | Preview hunk |
| `<leader>hr` | `n`, `v` | Reset hunk |
| `<leader>hs` | `n`, `v` | Stage hunk |
| `<leader>hu` | `n` | Undo stage hunk |
| `<leader>tb` | `n` | Toggle current line blame |
| `ih` | `o`, `x` | Select hunk (text object) |

## Debugging

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<F7>` | `n` | Step Into |
| `<F8>` | `n` | Step Over |
| `<F9>` | `n` | Continue |
| `<S-F8>` | `n` | Step Out |
| `<leader>db` | `n` | Toggle Breakpoint |
| `<leader>dc` | `n` | Breakpoint condition |
| `<leader>dl` | `n` | Launch Lua adapter |

## AI & Code Assistance

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>jv` | `v` | Send selection to Sidekick |
| `<leader>tC` | `n` | Toggle Sidekick (Claude) |
| `<leader>tP` | `n` | Toggle Copilot |

## Note Taking & Markdown

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>ga` | `n` | Follow internal markdown link |
| `<leader>tp` | `n` | Toggle markdown preview |

## UI & Toggles

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>fi` / `<leader>fm` / `<leader>fx` | `n` | Set fold method to indent / marker / treesitter |
| `<leader>nA` | `n` | Show all messages (Noice) |
| `<leader>nh` | `n` | Show message history (Noice) |
| `<leader>nl` | `n` | Show last message (Noice) |
| `<leader>nx` | `n` | Dismiss all messages (Noice) |
| `<c-b>`/`<c-f>`| `i,n,s` | Scroll backward/forward in Noice view |
| `<leader>ti` | `n` | Toggle more info in statusline |
| `<leader>tD` | `n` | Toggle diagnostics |
| `<leader>tf` | `n` | Toggle auto-formatting |
| `<leader>th` | `n` | Toggle inlay hints |
| `<leader>tl` | `n` | Toggle line number visibility options |
| `<leader>tS` | `n` | Toggle spell checking |
| `<leader>tc` | `n` | Toggle colorizer |
| `<leader>td` | `n` | Toggle diagnostic virtual lines |
| `<leader>tt` | `n` | Pick theme (Snacks) |
| `<leader>tw` | `n` | Toggle line wrap |
| `<leader>tx` | `n` | Toggle Treesitter Context |
| `<S-Enter>` | `c` | Redirect command-line output through Noice |
| `z0` / `z1`... | `n` | Set code fold level |
| `zm` | `n` | Set marker folds and close all folds |
| `zV` | `n`, `x` | Close all folds except the current one |

## Miscellaneous

| Key | Mode(s) | Description |
| --- | --- | --- |
| `<leader>Li` / `<leader>Lp` | `n`, `v` | Inspect / Print Lua code |
| `<leader>P` | `n` | Update packages with `vim.pack.update()` |
| `<leader>lf` | `n` | Format file (conform) |
| `<leader>om` | `n` | Open Mason |
| `<Space>D` | `x` | Diff visual selection against clipboard |
| `q` | `n` | Close quickfix, help, man, notify, LSP info, and similar utility windows |

## mini.clue Prefixes

These are prefixes that open a menu of subsequent key bindings.

| Key | Mode(s) | Group Name |
| --- | --- | --- |
| `"` | `n`, `x`| Registers |
| `'`/`` ` `` | `n`, `x`| Marks |
| `,` | `n`, `x` | Custom Mappings |
| `<leader>` | `n`, `v`| Main Leader Menu |
| `g` | `n`, `x`| Go |
| `[`/`]` | `n` | Brackets / Hunks / Diagnostics |
| `z` | `n`, `x`| Folds / Spelling |
