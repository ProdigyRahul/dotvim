# Chapter 5: Visual Mode (use it deliberately)

## Goal

By the end of this chapter you will:

- Use Visual mode for what it is best at (block edits, quick one-offs).
- Avoid Visual mode for things text objects can do better.
- Be comfortable with blockwise Visual (`<C-v>`), which is huge for code.

## Why Visual mode is tricky

Visual mode feels familiar because it resembles selection-based editors.

But in Vim, Visual mode is often slower and less precise than text objects.

Use Visual mode when:

- you need a rectangular/block edit
- you need to transform a unique selection once
- you want to apply an Ex command to a selection (`:'<,'>...`)

Avoid Visual mode when:

- you are editing inside quotes/parens/braces (use `ci"`/`ci(`/`ci{`)
- you are deleting a word/paragraph (use `daw`/`dap`)

## Visual modes

- `v` character-wise selection
- `V` line-wise selection
- `<C-v>` block-wise selection

Useful Visual commands:

- `gv` reselect last visual selection
- `o` swap cursor to other end of selection
- `:` run command on selection (auto-fills range `'<,'>`)

## Blockwise Visual (the programmer's friend)

This is the real unlock:

- `<C-v>` select a column
- `I` insert at start of each selected line
- `A` append at end of each selected line

## Drills (do in `:enew`)

Paste:

```txt
one
two
three
four
five
```

Do each 5-10 times.

1. Prefix every line:
   - `<C-v>` select the first column down 5 lines
   - press `I` and type `// `
   - `<Esc>` to apply to all lines
   - Why: bulk edits without macros.
2. Align assignments:
   - Make a snippet:
     - `a=1`
     - `bbb=2`
     - `cc=3`
   - Use `<C-v>` + insert spaces to line up `=`.
   - Why: block mode is for "column" thinking.
3. Use `gv`:
   - Make a visual selection, indent with `>` (or reindent with `=`), then hit `gv` and do another action.
   - Why: chaining operations without reselecting.

## Real-code mission (30-60 minutes)

In a real file:

- Add or remove a prefix on 10 lines (logging, commenting, etc.) using blockwise Visual.
- Use Visual range + substitute:
  - select a block of lines
  - run `:'<,'>s/foo/bar/gc`

## Common mistakes

- Getting "stuck" in Visual mode. Press `<Esc>` and go back to Normal.
- Using Visual to select "inside braces". Use `ci{` or `vi{`.

## Help to read

- `:h visual-mode`
- `:h blockwise-operators`
- `:h gv`

