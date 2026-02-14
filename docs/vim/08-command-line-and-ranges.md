# Chapter 8: Command-line and Ranges (surgical batch edits)

## Goal

By the end of this chapter you will:

- Use `:` commands with ranges confidently.
- Edit command history using the command-line window (`q:`).
- Use `:normal` to apply Normal-mode actions to many lines.

## Why this matters

Normal mode is great for one edit.

Ex mode is how you scale an edit to:

- a visual selection
- a line range
- the whole file
- or "only lines that match X"

## Command-line editing (quality-of-life)

### Command history window

- `q:` opens the command-line window for `:` history.
- `q/` opens it for search history.

Inside that window:

- edit the command like a normal buffer
- press `<Enter>` on a line to execute it

Why: you stop retyping long commands.

## Ranges (the most important concept)

You will see ranges in the form `:{range}{command}`.

Common ranges:

- Current line: `:.`
- Whole file: `:%`
- Current line to end: `:.,$`
- Visual selection: `:'<,'>` (auto-inserted when you press `:` in Visual)
- Specific lines: `:10,20`

Examples:

- Substitute only on lines 10-20:
  - `:10,20s/foo/bar/gc`
- Indent lines 5 to end:
  - `:5,$normal >>`

## `:normal` (batch apply Normal-mode keys)

Syntax:

- `:{range}normal {keys}`

Examples:

- Add `;` to end of each line in a visual selection:
  - select lines with `V` then
  - `:'<,'>normal A;<Esc>`

Why: you can reuse your Normal-mode skills at scale.

## `:global` with ranges (combo)

You can combine targeting and action:

- `:g/pattern/normal {keys}`

Example: on lines containing `console.log`, comment them:

- `:g/console\\.log/normal I// <Esc>`

## Drills (do in `:enew`)

Paste:

```txt
alpha
beta
gamma
delta
epsilon
```

Do each 5-10 times.

1. Use a visual range:
   - Select lines 2-4 with `Vjj`.
   - Run `:'<,'>normal A;<Esc>` to add semicolons.
2. Use a numeric range:
   - Undo, then run `:2,4normal I>> <Esc>` to prefix.
3. Use `q:`:
   - Run a long substitute, then press `q:` and edit the command to tweak it.
   - Execute the edited command from the window.

## Real-code mission (60-180 minutes)

Do one real batch change using `:normal`:

- add `await` before a set of calls on multiple lines
- wrap selected lines with `try { ... }`
- insert a logging line after matched lines (`:g/pattern/normal o...`)

Rules:

- Start in a scratch file first.
- Once you trust it, apply to real code.

## Common mistakes

- Forgetting that `:normal` needs `<Esc>` inside the keys if you enter Insert mode.
- Using an unsafe range (using `%` when you meant a selection).

## Help to read

- `:h q:`
- `:h cmdline-window`
- `:h :range`
- `:h :normal`
- `:h :global`

