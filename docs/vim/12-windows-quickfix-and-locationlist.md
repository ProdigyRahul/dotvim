# Chapter 12: Windows, Quickfix, Location List (work like a pro)

## Goal

By the end of this chapter you will:

- Use splits/windows without getting lost.
- Understand the difference between window, buffer, and tab.
- Use quickfix/location lists to process multiple results efficiently.

Note: your setup keeps only one file-buffer. Windows are still useful for:

- help (`:h`)
- terminals
- quickfix
- side panels (neo-tree)

## Window basics

### Open splits

- `:split` horizontal split
- `:vsplit` vertical split

### Move between windows

- `<C-w>h` left
- `<C-w>j` down
- `<C-w>k` up
- `<C-w>l` right

Your config also maps window navigation in Normal mode:

- `<C-h>` `<C-j>` `<C-k>` `<C-l>`

### Close windows

- `:close` close current window
- `:only` close all other windows

### Resize windows

- `<C-w>+` / `<C-w>-` height
- `<C-w>>` / `<C-w><` width

Your config also has fast resizing:

- `<A-h>` `<A-j>` `<A-k>` `<A-l>`

## Buffers vs windows vs tabs (concept)

- A buffer is file content in memory.
- A window is a viewport onto a buffer.
- A tab is a layout of windows.

Even with single-buffer behavior, this mental model matters for help/quickfix/term.

## Quickfix (global list of locations)

Quickfix is a list of file:line entries you can jump through.

Commands:

- `:copen` open quickfix window
- `:cclose` close it
- `:cnext` / `:cprev` go next/prev entry
- `:cfirst` / `:clast`

Power tools:

- `:cdo {cmd}` run an Ex command for each quickfix entry
- `:cfdo {cmd}` run an Ex command for each file in the list

## Location list (per-window list)

Same concept as quickfix, but scoped to a window:

- `:lopen` / `:lclose`
- `:lnext` / `:lprev`

## How to get entries into quickfix

Common ways:

1. LSP diagnostics list:
   - You can open a diagnostics list with `:lua vim.diagnostic.setqflist()`
2. `:grep` / `:vimgrep`
   - This depends on your `grepprg` config.
3. Telescope:
   - many Telescope pickers can send results to quickfix (often with `<C-q>`).

If you want, I can add a small config to make `:grep` use ripgrep (`rg`) reliably.

## Drills (do in `:enew`)

Paste:

```txt
TODO: first
ok
TODO: second
ok
TODO: third
```

Do each 5-10 times.

1. Use `:global` into quickfix (simple simulation):
   - Run: `:g/TODO/#`
   - This prints line numbers; now practice navigation with `:1`, `:3`, etc.
2. Window navigation:
   - Open help: `:h quickfix`
   - Split: `:vsplit`
   - Move between windows with `<C-w>h/j/k/l`
3. Close discipline:
   - Use `:only` to get back to one window quickly.

## Real-code mission (60-180 minutes)

Pick a refactor that produces multiple hits:

- search for a function name and update all call sites

Workflow:

1. Use Telescope live grep (`<leader>fg`) to find occurrences.
2. Send results to quickfix (if your Telescope mapping supports it) or use LSP references (`gr`).
3. Use `:cnext` / `:cprev` to process each hit.
4. Apply consistent edits with `.` or a macro.

## Common mistakes

- Treating windows as "files". Windows are just views; learn `<C-w>` movement.
- Ignoring quickfix and doing search-hit processing manually.

## Help to read

- `:h windows`
- `:h quickfix`
- `:h location-list`
- `:h :cdo`

