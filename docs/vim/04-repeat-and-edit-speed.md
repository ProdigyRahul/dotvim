# Chapter 4: Repeat and Edit Speed (multipliers)

## Goal

By the end of this chapter you will:

- Use `.` as your main speed tool.
- Use change navigation (`g;`, `g,`) to revisit edits.
- Use "repeat families": `;`, `&`, `@@`, `@:` depending on context.

## Why this matters

Vim is fast because you rarely do the same work twice.

The correct workflow is:

1. do the first edit carefully
2. repeat it everywhere else using the smallest repeat tool

## Repeat tools (memorize)

- `.` repeat last change (best tool in Vim)
- `;` repeat last `f`/`t` motion (within a line)
- `&` repeat last `:s` substitution (same flags)
- `@:` repeat last `:` command
- `@@` repeat last executed macro

Navigation through your own edits:

- `g;` jump to older change (change list)
- `g,` jump to newer change

Undo/redo:

- `u` undo
- `<C-r>` redo

## Your setup: UndoTree (visualize time travel)

You have `undotree` installed.

- Toggle UndoTree: `<leader>u` (runs `:UndotreeToggle`)

Why this matters:

- Undo is not linear when you branch edits.
- UndoTree lets you jump to an older state, explore, and come back without losing work.

## How to make `.` work for you

`.' repeats an *edit*, not "the exact keys".

So you want to make edits that are:

- small
- consistent
- targetable

Example: if you need to add `,` at end of many lines:

1. Go to end of line: `$`
2. Enter insert: `a,` then `<Esc>`
3. Next line: `j` then `.` (repeat)

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

1. Add semicolons:
   - On `alpha` line, do `A;<Esc>`.
   - Then do `j.` to repeat on each next line.
   - Why: `.` is the core multiplier.
2. Repeat `f` motion:
   - In a line like `a = b + c + d + e`, use `f+` to jump to `+`, then `;` to repeat.
   - Why: scanning a line is faster with repeat motions.
3. Change list navigation:
   - Make 5 edits in different places.
   - Use `g;` to go backward through edits, `g,` to go forward.
   - Why: "where did I just change that?" becomes instant.

4. UndoTree drill (in any real file):
   - Make 10 edits in different places.
   - Open UndoTree: `<leader>u`
   - Move around in the tree and restore an older state.
   - Close UndoTree: `<leader>u`
   - Why: learn to recover and explore safely.

## Real-code mission (45-90 minutes)

Pick any file and do a small repetitive refactor with `.`:

- add/remove `await`
- add trailing commas
- add a `console.log` line under multiple branches

Rules:

- You must use `.` for at least 20 edits.
- If you catch yourself repeating manual edits, stop and redesign the edit.

## Common mistakes

- Doing different edits each time, making `.` useless.
  - Fix: use a text object so each edit becomes identical.
- Forgetting `g;` exists and searching manually for your last edit.

## Help to read

- `:h .`
- `:h g;`
- `:h undo`
