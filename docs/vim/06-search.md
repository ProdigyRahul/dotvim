# Chapter 6: Search (find fast, then edit fast)

## Goal

By the end of this chapter you will:

- Navigate by search instead of scrolling.
- Use `*`/`#` and `g*`/`g#` correctly.
- Use `cgn` to do safe, fast renames without multi-cursor.

## Why search is not just for finding

Search is a motion system:

- you can jump to matches (`n`/`N`)
- you can operate on matches (`cgn`, `dgn`)
- you can use search as "navigation memory" (jump back with `<C-o>`)

## Search basics (you already know `/`)

- `/pattern` search forward
- `?pattern` search backward
- `n` next match
- `N` previous match

Your config:

- Press `<Esc>` to clear search highlight (`:nohlsearch`).

## Search shortcuts for code

### Word under cursor

- `*` search forward for the exact word under cursor
- `#` search backward for the exact word under cursor

When "exact word" is too strict:

- `g*` search forward for partial match
- `g#` search backward for partial match

Why:

- `*` is perfect for variables like `userId`
- `g*` is useful when the token is part of a longer identifier

### Search history window (huge quality-of-life)

- `q/` opens a searchable, editable window of your previous searches

Why: complex searches are easier to edit than to retype.

## Editing matches: `gn` and `cgn`

These are the "rename without multi-cursor" tools.

- `gn` selects the next match of the current search pattern
- `cgn` changes the next match (enter Insert mode)
- `dgn` deletes the next match

Typical rename workflow:

1. Put cursor on a symbol.
2. Press `*` to search it.
3. Press `cgn`, type new name, `<Esc>`.
4. Repeat for the next match:
   - often `.` is enough (repeats `cgn` on the next match)
   - if you moved around, use `n` then `.` to be explicit

Why this is safer than multi-cursor:

- You can confirm each occurrence.
- You can stop when you hit a false positive.

## Drills (do in `:enew`)

Paste:

```ts
const userId = 123;
function logUser(userId: number) {
  console.log("userId", userId);
  return { userId };
}
// userId should not be renamed inside userId2
const userId2 = 456;
```

Do each 5-10 times.

1. Exact word jump:
   - Put cursor on `userId` and press `*` then `n` / `N`.
   - Verify it does NOT jump to `userId2`.
2. Partial match jump:
   - Put cursor on `userId` and press `g*` then `n`.
   - Verify it DOES jump to `userId2`.
   - Why: learn when partial is dangerous.
3. Rename with `cgn`:
   - Use `*` to search `userId`.
   - Do `cgn` -> type `accountId` -> `<Esc>`.
   - Repeat for next match using `.` (or `n.`).
   - Stop when you reach the comment and confirm behavior.
4. Edit search via `q/`:
   - Press `/userId` then `<Enter>`.
   - Press `q/` and edit it to `\\vuserId(2)?` then run it.
   - Why: editing beats retyping.

## Real-code mission (60-120 minutes)

Pick a codebase and do a real rename.

Rules:

- Start with `*` to set the search pattern.
- Use `cgn` + `.` (or `n.`) to apply.
- Stop and inspect after every 5 changes.
- Use `u` to undo if you see a wrong match.

## Common mistakes

- Using `g*` when you meant `*` and renaming too much.
- Forgetting that `*` uses "word boundaries". If you need stricter matching, use `:%s` with regex.

## Help to read

- `:h /`
- `:h *`
- `:h g*`
- `:h gn`
- `:h q/`

