# Chapter 10: Macros (`q` and `@`) (automation in Vim)

## Goal

By the end of this chapter you will:

- Record a macro that works the first time.
- Replay it with counts (`10@a`) or across a selection (`:'<,'>normal @a`).
- Debug and edit macros when they go wrong.

## Why macros are a superpower

Macros are for edits that are:

- repetitive
- structured
- not worth writing a script for

If you can do the first one, Vim can do the next 50.

## The commands

- Start recording into register `a`: `qa`
- Stop recording: `q`
- Play macro `a`: `@a`
- Play last macro again: `@@`
- Play macro 10 times: `10@a`

Macro registers are just registers. You can view them:

- `:reg a`

## Macro mindset (how to make them reliable)

1. Make the macro robust:
   - use searches (`/pattern`) inside the macro instead of manual movement
   - use text objects (`ci"`, `dap`) instead of Visual selection
2. Keep the macro small:
   - one "unit of work" per macro
3. Validate early:
   - record, then run on the next 1-2 lines first
4. Use undo:
   - if it goes wrong, `u` back out and re-record

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

### Drill 1: Append a semicolon to every line

1. Put cursor on the first line.
2. Record macro:
   - `qa`
   - `A;<Esc>`
   - `j`
   - `q`
3. Run it:
   - `4@a` (because 4 remaining lines)

Why: teaches the basic record/replay loop.

### Drill 2: Wrap each line in a function call

Goal: convert `alpha` -> `log("alpha")`

1. Undo to restore.
2. Record:
   - `qa`
   - `0ilog("<Esc>`
   - `A")<Esc>`
   - `j`
   - `q`
3. Run `4@a`.

Why: teaches combining `0`, `i`, `A` inside macros.

### Drill 3: Apply macro to a visual selection (range execution)

1. Select the lines with `V`.
2. Run: `:'<,'>normal @a`

Why: you can apply macros without counting.

## Debugging and editing macros

When a macro is almost right:

1. Inspect it:
   - `:reg a`
2. Edit it (simple method):
   - paste the macro into a scratch buffer:
     - `:enew`
     - `"ap` (paste macro text)
   - edit the text (it will look like keystrokes)
   - yank it back into register `a`:
     - select the line, then `"ay`

This is not pretty, but it works when you need to fix a macro quickly.

## Real-code missions (pick 1-2)

1. Convert a list of values into an array/object format.
2. Add a logging line under multiple similar branches.
3. Add `await` or `.catch(...)` to repeated call sites in a local section.

Rules:

- Record a macro that changes one instance.
- Run it on 2 more instances.
- If correct, apply it to the rest.

## Common mistakes

- Forgetting to leave Insert mode inside the macro (always end with `<Esc>`).
- Using `j` when lines may wrap or differ. Prefer search + text objects when possible.
- Recording extra accidental keystrokes. Re-record; don't fight it.

## Help to read

- `:h q`
- `:h @`
- `:h :normal`
- `:h :reg`

