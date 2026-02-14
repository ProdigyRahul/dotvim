# Chapter 7: Substitute and Regex (project-grade editing)

## Goal

By the end of this chapter you will:

- Use `:s` confidently with confirmations.
- Understand the 20% of Vim regex that covers most refactors.
- Use `:g` to batch-edit lines (hard power tool).

## Why this matters

Search finds. Substitute transforms.

Once you're fluent with `:s` you can do safe, large changes without plugins.

## Substitute basics

- `:s/old/new/` substitute on the current line (first match)
- `:s/old/new/g` substitute all matches on the current line
- `:%s/old/new/g` substitute across the whole file
- Add confirmation:
  - `:%s/old/new/gc`

Flags you will actually use:

- `g` global (all matches per line)
- `c` confirm each match
- `i` ignore case (overrides smartcase)

Tip: if your pattern contains `/`, change the delimiter:

- `:%s#foo/bar#baz#gc`

## The regex you need (not everything)

### Character classes

- `.` any character
- `\\s` whitespace
- `\\d` digit
- `\\w` word character

### Quantifiers

- `*` 0 or more
- `+` 1 or more
- `\\?` 0 or 1
- `{n}` exactly n (Vim uses `\\{n}` in default magic, see below)

### Word boundaries

- `\\<` start of word
- `\\>` end of word

Example: replace `foo` but not `foobar`:

- `:%s/\\<foo\\>/bar/gc`

## "Very magic" mode (recommended)

Vim's default regex requires lots of escaping.

Use `\\v` ("very magic") to make patterns look more like standard regex:

- `:%s/\\v\\<foo\\>/bar/gc`

In `\\v`:

- `()` groups without escaping
- `{}` counts without escaping

## Practical substitutions (programmer favorites)

1. Remove trailing whitespace:

```vim
:%s/\\s\\+$//g
```

2. Replace double spaces with one (careful):

```vim
:%s/\\v  +/ /g
```

3. Rewrite import path prefix:

```vim
:%s#\\vfrom\\s+\"@/lib/#from \"@/server/lib/#g
```

## `:global` and `:vglobal` (hard but worth it)

- `:g/pattern/ cmd` runs `cmd` on every line that matches `pattern`
- `:v/pattern/ cmd` runs `cmd` on every line that does NOT match

Examples:

- Delete all TODO lines:
  - `:g/TODO/d`
- Keep only lines containing `ERROR`:
  - `:%!` is another approach, but with global:
  - `:v/ERROR/d`

## Drills (do in `:enew`)

Paste:

```txt
foo foofoo foobar foo
TODO: remove me
ok
TODO: also remove me
ERROR: bad thing
```

Do each 5-10 times.

1. Word-boundary replace:
   - Replace only standalone `foo` with `bar`:
     - `:%s/\\<foo\\>/bar/gc`
   - Why: avoids accidental refactors.
2. Remove TODO lines:
   - `:g/TODO/d`
   - Why: learn `:g` on safe text first.
3. Keep only errors:
   - `:v/ERROR/d`
4. Trailing whitespace cleanup:
   - Add spaces at end of some lines.
   - Run `:%s/\\s\\+$//g`

## Real-code mission (60-180 minutes)

Do a real change in a code file using only Ex commands:

Options:

- Rename an import path prefix across a file
- Remove trailing whitespace in a file you touched
- Convert `var` to `const` in a small file (use confirmations)

Rules:

- Always start with `c` confirmations until you trust the pattern.
- After you confirm it's correct, you can remove `c` for speed.

## Common mistakes

- Running `:%s/.../.../g` without `c` on a new pattern.
- Not using word boundaries and replacing too much.
- Forgetting you can change delimiters to avoid escaping.

## Help to read

- `:h :substitute`
- `:h pattern`
- `:h \\v`
- `:h :global`

