# Chapter 9: Registers (copy/paste with intention)

## Goal

By the end of this chapter you will:

- Use named registers for "prepared snippets".
- Paste registers in Insert mode with `<C-r>`.
- Understand where text goes when you delete/yank.

## Why registers matter

Most people think Vim has one clipboard.

Vim actually has many:

- last yank
- last deletes
- named storage
- system clipboard
- last search, last command, last inserted text

Once you use registers intentionally, you stop losing text.

## The register mental model

You choose a register with `"{register}` before an operator.

Examples:

- `"ayy` yank a line into register `a`
- `"ap` paste register `a`
- `"_daw` delete a word into the black hole (don't overwrite your yank)

Inspect registers:

- `:reg`

## Registers you should actually know

- `"` unnamed register (default paste)
- `0` last yank register
- `1`..`9` delete history (recent deletes)
- `-` small delete register (small deletions)
- `_` black hole (discard)
- `+` system clipboard (works with OS clipboard)
- `*` primary selection (mostly on Linux/X11)
- `/` last search pattern
- `:` last command-line command
- `.` last inserted text

## Insert-mode paste (huge)

While in Insert mode:

- `<C-r>{register}` inserts that register's contents

Examples:

- `<C-r>"` insert the unnamed register
- `<C-r>0` insert last yank
- `<C-r>a` insert register `a`

Why: you can paste without leaving Insert mode.

## Drills (do in `:enew`)

Paste:

```txt
first line
second line
third line
```

Do each 5-10 times.

1. Named register storage:
   - Put cursor on `first line`, do `"ayy`
   - Go to end, do `"ap` twice
   - Why: learn explicit storage/paste.
2. Black hole delete:
   - Yank `second line` with `yy`
   - Delete `third line` using `dd` (notice it overwrites your paste)
   - Undo, then delete with `"_dd`
   - Paste with `p` and confirm you still have the original yank
3. Insert-mode paste:
   - Yank a word with `yiw`
   - Enter Insert mode elsewhere and do `<C-r>0` to insert it

## Real-code mission (30-90 minutes)

In real code:

- Store a useful snippet in `"a` (like a log line or a common pattern).
- Paste it 10 times in different contexts using `"ap`.
- Use `"_d` whenever you delete something you do not want to replace your yank.

## Common mistakes

- Overwriting your yank with a delete. Use `"_d` when you want to preserve clipboard.
- Forgetting that `0` keeps the last yank even if you delete afterward.

## Help to read

- `:h registers`
- `:h quote`
- `:h i_CTRL-R`
- `:h :reg`

