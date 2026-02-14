# Chapter 11: Marks, Jumps, and Lists (navigation memory)

## Goal

By the end of this chapter you will:

- Set marks and jump to them reliably.
- Use jump history (`<C-o>` / `<C-i>`) as "back/forward".
- Use change list (`g;` / `g,`) to revisit edits quickly.

This chapter is extra important because your setup keeps only one file-buffer open at a time.
Marks/jumps are how you keep context across file switches.

## Why this matters

Good programmers don't just "move around". They:

- leave breadcrumbs (marks)
- jump to definitions/references quickly (LSP)
- return instantly (jumplist)
- revisit changes (changelist)

## Marks (bookmarks inside files)

### Set a mark

- `ma` sets mark `a` in the current file (lowercase marks are file-local)

### Jump to a mark

- `'a` jump to the line of mark `a`
- `` `a`` jump to the exact position (line + column)

### Useful special jumps

- `''` jump back to the previous position (line-wise)
- `` `` `` jump back to the previous position (exact)

Inspect marks:

- `:marks`

## Jumplist (where you have been)

- `<C-o>` jump back
- `<C-i>` jump forward

When you use `gd`, `/search`, `gg`, `G`, etc., you are building a jumplist.

Inspect:

- `:jumps`

## Changelist (where you edited)

- `g;` jump to older change
- `g,` jump to newer change

Inspect:

- `:changes`

Why: "Where did I just change that?" becomes instant.

## Drills (do in `:enew`)

Paste:

```ts
function a() {
  return 1;
}

function b() {
  return 2;
}

function c() {
  return 3;
}
```

Do each 5-10 times.

1. Marks:
   - Put cursor in `function a`, set mark `ma`.
   - Go to `function c`, set mark `mc`.
   - Jump between them using `'a` and `'c`.
   - Repeat using `` `a`` and `` `c``.
2. Jumplist:
   - Search `/return`, press `n` a few times.
   - Press `<C-o>` repeatedly to go back through jumps.
   - Press `<C-i>` to go forward.
3. Changelist:
   - Make 5 edits in different functions.
   - Use `g;` to jump to each edit site.

## Real-code mission (30-90 minutes)

Pick a real file you will work in today.

- Set 3 marks (`ma`, `mb`, `mc`) at important points.
- Use `gd` / `gr` to jump around.
- Use `<C-o>` / `<C-i>` to return instead of searching.
- When you feel lost, use `:jumps` and `:changes` instead of guessing.

## Common mistakes

- Using marks but forgetting `'a` vs `` `a``. Remember:
  - `'` goes to line
  - `` ` `` goes to exact column
- Not using `<C-o>` after `gd` and then trying to "find your way back" manually.

## Help to read

- `:h marks`
- `:h jumplist`
- `:h changelist`

