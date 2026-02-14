# Chapter 3: Operators and Text Objects (edit by meaning)

## Goal

By the end of this chapter you will:

- Stop using Visual mode for most edits.
- Use built-in text objects (`iw`, `ap`, `i"`, `i{`, etc.) fluently.
- Use Treesitter text objects from your config (`af`, `if`, `aa`, `ia`, etc.) for code structure.

## Why this matters

Programmer edits are usually "change the thing inside X":

- inside quotes
- inside parens/brackets
- inside an object
- inside a function
- a parameter

Text objects let you target those meaningfully without selecting.

## Operators (verbs)

You already use `d` and `c`. Add these:

- `y` yank (copy)
- `>` indent
- `<` outdent
- `=` reindent (format indentation)
- `gU` uppercase
- `gu` lowercase
- `g~` toggle case

Key idea: operators become powerful when combined with good targets.

Examples:

- `yap` copy a paragraph
- `>ip` indent a paragraph
- `gUiw` uppercase an identifier

## Built-in text objects (nouns)

### Words

- `iw` inner word (just the word)
- `aw` a word (word plus surrounding space)

Why: `daw` is great when removing function args separated by spaces/commas.

### Paragraphs

- `ip` inner paragraph
- `ap` a paragraph (includes surrounding newline)

### Quotes

- `i"` / `a"` inside/around double quotes
- `i'` / `a'` inside/around single quotes

### Brackets/parens/braces

- `i(` / `a(` inside/around parentheses
- `i[` / `a[` inside/around brackets
- `i{` / `a{` inside/around braces

Tip: if you forget: think "inside" = `i`, "around" = `a`.

## Your setup: Treesitter text objects

Your `lua/plugins/treesitter.lua` defines:

- Select:
  - `af` / `if` function (around/inside)
  - `ac` / `ic` class (around/inside)
  - `aa` / `ia` parameter (around/inside)
- Move:
  - `]m` next function start, `[m` previous function start
  - `]]` next class start, `[[` previous class start

Why: this is how you refactor at the function/argument level fast.

## Your setup: Surround editing (nvim-surround)

You have `kylechui/nvim-surround` enabled. It gives you fast "wrap / unwrap / change wrappers".

Core operations (default mappings):

- Add surround: `ys{motion}{char}`
  - Example: `ysiw"` turns `word` into `"word"`
- Delete surround: `ds{char}`
  - Example: `ds"` turns `"word"` into `word`
- Change surround: `cs{target}{replacement}`
  - Example: `cs"'` turns `"word"` into `'word'`

Why this matters:

- Wrapping/unwrapping arguments, strings, JSX, and function calls becomes a few keystrokes.
- These actions are dot-repeatable (`.`), which multiplies speed.

## Drills (do in `:enew`)

Paste this:

```ts
export function greet(name: string, city: string) {
  const msg = "Hello " + name + " from " + city;
  return msg;
}

class UserService {
  createUser(name: string, city: string, active: boolean) {
    return { name, city, active };
  }
}
```

Do each 5-10 times.

1. Quotes:
   - Put cursor anywhere in `"Hello "`.
   - Do `ci"` and type `Hi `.
   - Why: fastest way to change string contents.
2. Parentheses:
   - Put cursor inside `(name: string, city: string)`.
   - Do `ci(` then type `name: string, city: string, country: string`.
   - Why: rewrite args without deleting parentheses.
3. Parameter object:
   - Put cursor on `active` in `{ name, city, active }`.
   - Do `daw` to remove it.
   - Undo; then do `cia` on `active` to change parameter name (Treesitter param object).
   - Why: built-in word vs structured param object.
4. Function scope (Treesitter):
   - Put cursor inside `createUser(...)`.
   - Do `vif` to select inside function, then `=` to reindent.
   - Why: selection as a temporary tool, then formatting.
5. Move by function:
   - Use `]m` / `[m` to jump between functions.
   - Why: refactor by navigating structure.

6. Surround (add/delete/change):
   - Put cursor on `msg` and do `ysiw"` (wrap in quotes).
   - Then do `ds"` (remove quotes).
   - Then do `ysiw)` (wrap with parentheses).
   - Then do `cs)("` (change parens to quotes).
   - Why: surround edits are common in real code and faster than manual typing.

## Real-code mission (60-120 minutes)

Pick a file with at least 3 functions.

Tasks:

1. Reformat indentation on 3 functions using `vif` + `=`.
2. Rename a parameter (one at a time) using `cia` and `.` to repeat if possible.
3. Rewrite one function signature using `ci(`, not Visual selection.

Rules:

- No mouse.
- Visual mode allowed only for `vif`/`vaf` style structure selection.

## Common mistakes

- Using Visual mode to select a word/argument. Use `ciw`, `caw`, `ci(`, `cia` instead.
- Confusing `iw` vs `aw`. Remember: `aw` tends to delete trailing spaces cleanly.

## Help to read

- `:h text-objects`
- `:h aw`
- `:h ip`
- `:h operator`
- `:h nvim-surround.usage`
