# Chapter 2: Motions (move less, target better)

## Goal

By the end of this chapter you will:

- Navigate precisely without "walking" with `j/k/h/l`.
- Use structural motions (`%`, `{}`, `[]`) to move by code shape.
- Use `f/t` + `;` as your default within-line navigation.

## Why motions matter

In Vim, movement is not just "moving". Motions are *targets* for operators.

If you know better motions, you write fewer keystrokes and make fewer mistakes:

- `dt,` is safer than selecting to a comma with Visual mode.
- `ci(` is safer than backspacing until it looks right.

## Motion toolkit (high value)

### Within a line

- `0` start of line (column 1)
- `^` first non-blank character
- `$` end of line
- `g_` last non-blank character

Why: code often has indentation; `^` and `g_` are "semantic line ends".

### Find characters (your daily driver)

- `f{char}` jump to next `{char}` on the line
- `F{char}` jump backward to `{char}`
- `t{char}` jump *to just before* `{char}`
- `T{char}` backward variant
- Repeat last `f/t`: `;` forward, `,` backward

Why: most edits are inside a line (arguments, commas, quotes, `=`).

### Word motions (you already know `w/b/e`)

Add these:

- `W` / `B` / `E` move by "WORD" (whitespace-separated)
- `ge` go backward to end of previous word

Why: `W` is great for URLs, long identifiers, or code like `foo.bar(baz)`.

### Paragraph/block motions

- `{` previous paragraph/block
- `}` next paragraph/block
- `(` previous sentence, `)` next sentence (useful in docs/comments)

Why: quick movement by "chunks" of text, not lines.

### File motions

- `gg` top of file
- `G` bottom of file
- `{count}G` go to line `{count}` (example: `42G`)

### Screen motions (move by what you see)

- `H` top of screen
- `M` middle of screen
- `L` bottom of screen
- Centering:
  - `zz` center cursor line
  - `zt` cursor line at top
  - `zb` cursor line at bottom

Why: centering reduces context switching while you refactor.

### Matching pairs and blocks (must learn)

- `%` jump between matching pairs: `()`, `{}`, `[]`, and more
- `[{` jump to previous `{`
- `]}` jump to next `}`

Why: when you refactor code blocks, `%` is a cheat code.

### Jump history (navigation memory)

- `<C-o>` jump back
- `<C-i>` jump forward

Why: after `gd` or a search, this is how you "go back".

## Drills (do in `:enew`)

Paste this snippet:

```ts
function buildUser(name: string, city: string, active: boolean) {
  return { name: name, city: city, active: active };
}

const msg = greet("Rahul", "Toronto", true);
```

Do each 5-10 times.

1. Inside-line targeting:
   - Put cursor anywhere on the `return { ... }` line.
   - Use `f:` to jump to the next `:` and `;` to repeat.
   - Why: learn `f` + `;` as a "scan this line" tool.
2. Delete to comma:
   - Place cursor on `name: name` and do `dt,`.
   - Undo with `u`, then do `d2t,` (counted).
   - Why: operators + motion + counts.
3. Change inside parentheses:
   - Put cursor inside `greet(...)` and do `ci(` then type `user.name, user.city, user.active` then `<Esc>`.
   - Why: arguments are an object.
4. Use `%` for block navigation:
   - Put cursor on `{` after `buildUser(...)`.
   - Press `%` to jump to the matching `}`.
   - Why: refactors often start by selecting the right scope.
5. Use `zz` every time you jump:
   - Search for `return`, hit `n`, then `zz`.
   - Why: train your brain to keep context visible.

## Real-code mission (45-90 minutes)

In a real code file:

- For 30 minutes, forbid yourself from using `j/k` more than 3 times in a row.
- Navigate within lines using `f/t` and `;`/`,` instead.
- Use `%` at least 20 times.

## Common mistakes

- Overusing `w/b` for within-line edits. Use `f/t` instead.
- Forgetting `;`/`,` exists (this is a big speed unlock).
- Treating `%` as "only for brackets". It's for structure.

## Help to read

- `:h f`
- `:h t`
- `:h ;`
- `:h %`
- `:h H`
- `:h jumplist`

