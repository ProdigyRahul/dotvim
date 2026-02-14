# Cheatsheet (your current setup + must-know Vim keys)

This is not "everything". It's the high-frequency keys that compound.

## Modes (must be automatic)

- Normal -> Insert: `i` `a` `I` `A` `o` `O`
- Insert -> Normal: `<Esc>`
- Visual: `v` (char), `V` (line), `<C-v>` (block)
- Operator-pending: happens after `d`/`c`/`y` etc

## The grammar

- `operator + motion` or `operator + text object`
  - Example: `daw` = delete "a word"
  - Example: `ci"` = change inside quotes
- Add a count: `3dw` = delete 3 words

## Navigation

- Within line: `0` `^` `$` `g_`
- Find char: `f{c}` `F{c}` `t{c}` `T{c}` then repeat: `;` / `,`
- Match pairs: `%`
- Screen: `zz` center, `zt` top, `zb` bottom
- Jumps: `<C-o>` back, `<C-i>` forward

## Editing

- Repeat last change: `.`
- Undo/redo: `u` / `<C-r>`
- Change:
  - `ci{` `ci(` `ci"` `ci'` `cip` `caw`
- Delete:
  - `di{` `di(` `di"` `dip` `dap`
- Yank/paste:
  - `yy` `p` `P`

## Search/replace

- Search: `/pattern` then `n` / `N`
- Word under cursor: `*` / `#` (exact), `g*` / `g#` (partial)
- Rename loop: search then `cgn` (change next match), then `.` for next
- Substitute: `:%s/old/new/gc`

## Registers and macros

- Pick register: `"{reg}` then operation (example: `"ayy`)
- Insert mode paste register: `<C-r>{reg}`
- Record macro: `qa ... q`
- Play macro: `@a`, repeat last macro: `@@`, count: `10@a`

## Your config: programmer workflow

LSP:
- Hover: `K`
- Definition: `gd`
- References: `gr`
- Diagnostics: `[d` `]d`

Telescope:
- Find files: `<C-p>` or `<leader>ff`
- Live grep: `<leader>fg`
- Buffers list: `<leader>fb`

Flash:
- Jump: `s`
- Treesitter jump: `S`

Files:
- Neo-tree: `<C-n>`
- Oil: `-` (parent dir), `<leader>-` (float)

Git:
- Next/prev hunk: `]c` / `[c`
- Stage/reset hunk: `<leader>hs` / `<leader>hr`
- Git status: `<leader>gs`

Terminal:
- Toggle: `<C-\\>`

Undo tree:
- Toggle: `<leader>u`

