# Chapter 17: Terminal and Automation (stay in Neovim)

## Goal

By the end of this chapter you will:

- Use ToggleTerm efficiently (open/close, navigate windows, exit terminal mode).
- Run command-line tools without leaving Neovim.
- Send code snippets to a terminal when useful.

## Why this matters

Many "slowdowns" are context switches:

- editor -> terminal -> editor

If you keep commands inside Neovim, you keep your mental state.

## ToggleTerm keymaps (your config)

Open/close:

- Toggle terminal: `<C-\\>`

Layouts:

- Float: `<leader>tf`
- Horizontal: `<leader>th`
- Vertical: `<leader>tv`
- Tab: `<leader>tt`

Extras:

- Node REPL: `<leader>tn`
- Python REPL: `<leader>tp`
- Htop: `<leader>tH`
- Send visual selection to terminal: `<leader>ts` (Visual mode)

## Terminal mode basics (how to not get stuck)

When your cursor is inside a terminal, you're in Terminal mode.

Your config adds:

- Exit terminal mode: `<C-x>` (returns to Normal mode)
- Window navigation in terminal:
  - `<C-h>` `<C-j>` `<C-k>` `<C-l>`

Why: you can move between windows without touching the mouse.

## Drills (30-60 minutes)

Do each 5-10 times.

1. Open float terminal and run a command:
   - `<leader>tf`
   - run `git status` or `ls`
   - `<C-x>` to exit terminal mode
   - `<C-\\>` to close
2. Split navigation from terminal:
   - open a help window: `:h terminal`
   - open terminal
   - move between them using `<C-h>` / `<C-l>` while still in terminal
3. Send selection:
   - in a scratch buffer, write a small JS snippet
   - select it (Visual mode)
   - `<leader>ts` to send it to terminal

## Real-code mission (60-180 minutes)

Do a normal dev session without leaving Neovim for terminal work:

- run `git` commands in ToggleTerm
- run tests/build commands in ToggleTerm
- use `<C-x>` and window navigation to switch between code and terminal

## Common mistakes

- Pressing `<Esc>` expecting to leave terminal mode. Use `<C-x>` in your setup.
- Opening too many terminals and losing track.
  - Fix: keep 1-2 terminals for your workflow.

