# Chapter 19: Capstone (prove mastery)

## Goal

This is a practical exam. If you can do these, you are "real Vim fluent".

## Capstone rules

- No mouse.
- No multi-cursor.
- Prefer text objects over Visual selection.
- Use `.` or macros for repetition.
- Use LSP/Telescope for navigation.

## Capstone A: Local refactor (1-2 hours)

Pick a file 200-800 lines long.

Do all of this in one session:

1. Rename a local symbol safely:
   - use `<leader>rn` OR `*` + `cgn` + `.` carefully
2. Extract a block:
   - use Treesitter object `vif` and cut/paste with registers
3. Do a repetitive edit in 20+ places using `.` (not manual repetition)
4. Use marks:
   - set 2-3 marks before major jumps
   - return using `'a`/`'b` or `<C-o>`

## Capstone B: Multi-file refactor (2-6 hours)

Pick one real change across a repo:

- update an import path prefix
- change an API endpoint string
- rename a shared util and update call sites

Required workflow:

1. Find occurrences:
   - `<leader>fg` (Telescope) OR `gr` (LSP refs) OR Spectre
2. Make first edit carefully using a text object.
3. Repeat with `.` or macro when possible.
4. Use Spectre for truly multi-file replace, in small batches.
5. Use git hunks to stage safely:
   - stage only what you intend with `<leader>hs`

## Capstone C: Macro challenge (30-60 minutes)

Create a macro that transforms lines of text.

Example inputs:

```txt
foo
bar
baz
```

Target outputs:

```txt
export const foo = ...
export const bar = ...
export const baz = ...
```

Requirements:

- record into `q` (or any register)
- run it with a count OR apply with `:'<,'>normal @q`
- if it breaks, fix by re-recording or editing the macro register

## Scoring (honest check)

You're good if:

- you can describe the edit before you do it
- you rarely "walk" with `j/k` to find targets
- you can repeat edits with `.` and macros naturally
- you use LSP/Telescope as your navigation baseline

If you fail:

- identify which chapter the failure belongs to
- redo that chapter's drills for 2 days

