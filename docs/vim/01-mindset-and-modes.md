# Chapter 1: Mindset and Modes (why Vim feels different)

## Goal

By the end of this chapter you will:

- Understand *why* Vim is fast (it's not "keybindings", it's a language).
- Stop "moving the cursor then editing" and start "editing by describing the target".
- Be able to explain any edit as: `count + operator + motion/text-object`.

## The big idea: Vim is a language

Most editors make you:

1. select the text (mouse/drag/shift-arrows)
2. apply an action (delete/change/copy)

Vim flips it:

1. choose an action (operator)
2. choose what it applies to (motion or text object)

This is why Vim scales: you build edits from small composable parts.

### The grammar

- Operators (verbs): `d` delete, `c` change, `y` yank/copy, `>` indent, `<` outdent
- Motions (nouns): `w` word, `}` paragraph, `f,` to a comma, `%` matching bracket
- Text objects (nouns): `iw` inner word, `ap` a paragraph, `i"` inside quotes, `af` a function (treesitter)

Examples:

- `dw` = delete a word
- `cib` = change inside parentheses/brackets (see `:h text-objects`)
- `yap` = copy a paragraph
- `>ip` = indent a paragraph

## Modes (why they exist)

Vim is modal so the same keys can mean different things without chord spam.

You mostly live in Normal mode and briefly enter other modes to do work.

- Normal: navigation + operators (home base)
- Insert: typing text
- Visual: selecting text (useful, but don't overuse)
- Command-line: `:` commands, searches `/`
- Operator-pending: after `d`/`c`/`y`, Vim is waiting for a motion/object

## Your setup basics (so you don't fight your config)

- Leader is `<Space>`.
- You do **not** have which-key popups, so you learn by repetition + cheatsheet.
- `:` has no command suggestions. This is good: you learn the real commands.
- When you open a new file, the previous file buffer closes (single-file buffer behavior).
- When you leave a named file buffer, it auto-saves.

For drills: use `:enew` (unnamed buffer, won't auto-save).

## Why this matters as a programmer

If you can precisely target "the thing you mean" (the argument, the string, the block),
you can refactor faster and with fewer mistakes.

The goal is not "type faster". It's "think in higher-level edits".

## Core habits (memorize these first)

1. Think before you press keys:
   - "I want to change inside quotes" -> `ci"`
   - "I want to delete to the next comma" -> `dt,`
2. Prefer a text object over Visual selection.
3. After doing something once, ask: "Can I repeat with `.`?"

## Micro-drills (10-15 minutes)

Open a scratch buffer: `:enew` and paste this:

```txt
const user = { name: "Rahul", city: "Toronto", active: true };
function greet(name, city) { return "Hello " + name + " from " + city; }
items.map((item) => item.value).filter(Boolean).join(",");
```

Do each 5-10 times. Say the sentence *out loud* before pressing keys.

1. Change inside quotes: move cursor anywhere in `"Rahul"` and do `ci"` then type `Alex` then `<Esc>`.
   - Why: targets text inside delimiters without selecting.
2. Delete a word without moving to the end: place cursor in `Toronto` and do `daw`.
   - Why: "a word" includes surrounding whitespace, which is often what you want.
3. Change inside parentheses: place cursor inside `(item)` and do `ci)` then type `x` then `<Esc>`.
   - Why: refactors arguments quickly.
4. Indent a block: put cursor on `function greet...` line, do `>>`, then undo with `u`.
   - Why: indentation is an operator too.
5. Repeat an edit: append `!` to the end of the `"Hello "` string using a change, then use `.` on the next string.
   - Why: repeating is the multiplier.

## Real-code mission (30-60 minutes)

Pick any code file (TS/JS is ideal).

Rules:

- No mouse selection.
- Every edit must be described as "operator + target" before you do it.
- Any repeated edit must be done once, then repeated with `.`.

## Self-check (you should be able to answer)

- What is the difference between a motion and a text object?
- Why is `ci"` better than selecting between quotes and typing?
- What does `daw` delete that `diw` does not?

## Help to read

- `:h modes`
- `:h operator`
- `:h motion.txt`
- `:h text-objects`

