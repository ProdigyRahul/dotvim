# Vim Mastery (with your current Neovim setup)

This is a chapter-by-chapter training program to make you fluent in Vim/Neovim for real programming work.

Important: nobody knows "100% of Vim". The goal is to master the commands and mental models that cover almost all daily editing/navigation, and to learn how to use `:help` to quickly learn anything else on demand.

## How to use this

1. Follow `docs/vim/00-month-plan.md` as your schedule.
2. Read one chapter.
3. Do the drills in a scratch buffer first, then do the "real code mission" in your codebase.
4. Use `docs/vim/progress.md` to track what you can do without thinking.

## Your setup notes (so drills match reality)

- Leader key: `<Space>`
- You intentionally disabled:
  - leader popups (which-key)
  - `:` command suggestions (cmdline completion)
  - bufferline (buffer tabs)
- You have "single-file buffer" behavior:
  - when you open another file, the previous file buffer gets closed
  - when you leave a named file buffer, it auto-saves (without triggering formatters)

This affects how you should practice:

- For drills: use an **unnamed scratch buffer** so nothing is saved:
  - `:enew`
  - paste some text
  - practice freely
- For real-code missions: your auto-save is helpful, but be aware that opening file B will close file A.

## The only help commands you need to remember

- `:h {thing}` opens help.
  - Examples: `:h text-objects`, `:h cgn`, `:h :substitute`
- `:h usr_toc.txt` is the built-in Vim user manual table of contents.
- In help:
  - jump to a link/tag: `<C-]>`
  - go back: `<C-t>`
  - search inside help: `/pattern` then `n` / `N`

## Start here

- `docs/vim/cheatsheet.md` (quick reference)
- `docs/vim/01-mindset-and-modes.md` (the grammar that makes Vim click)

