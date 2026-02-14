# Chapter 14: Telescope, Flash, and File Tools (move through projects)

## Goal

By the end of this chapter you will:

- Open files and search code using Telescope as default.
- Use Flash (`s`, `S`) to jump precisely without scanning.
- Use your file tools (neo-tree, Oil) without losing time.

## Why this matters

In real projects, the bottleneck is often:

- finding the right file
- finding the right spot in the file
- jumping between related code quickly

This chapter is your "developer navigation stack".

## Telescope (fuzzy finder)

Your keymaps:

- Find files: `<C-p>` or `<leader>ff`
- Live grep: `<leader>fg`
- Buffers list: `<leader>fb` (less useful with single-file buffer, still fine)
- Help tags: `<leader>fh`

How to use it:

1. Open picker.
2. Type a few characters (fuzzy match).
3. Use `<CR>` to open selection.

Tip: treat Telescope as your "open anything" muscle.

## Flash (fast jump inside a file)

Your keymaps:

- `s` jump
- `S` treesitter jump

How to use `s`:

1. Press `s`
2. Type 1-2 characters you can see on screen
3. Press the label key to jump

Why: this replaces lots of `w`/`f` walking on dense code.

## Neo-tree and Oil (file browsing)

- Neo-tree toggle: `<C-n>`
- Oil open parent dir: `-`
- Oil float: `<leader>-`

Use cases:

- Neo-tree: project structure, quick file open, explorer
- Oil: file operations and quick browsing in the current directory context

## Harpoon (fast file slots)

You have Harpoon 2 enabled. Think of it as "5 quick bookmarks for files you bounce between".

Keymaps:

- Add current file: `<leader>ha`
- Toggle Harpoon menu: `<leader>hh`
- Jump to slot 1-5: `<leader>1` ... `<leader>5`
- Prev/next Harpoon file: `<C-S-P>` / `<C-S-N>`

Why: when you're working across 2-5 files (controller/service/schema/etc), Harpoon beats searching every time.

## Drills (30-60 minutes)

Do each 5-10 times.

1. Telescope file open drill:
   - open `<C-p>`
   - open a file
   - immediately jump to a symbol with search (`/`) or Flash (`s`)
2. Telescope grep drill:
   - `<leader>fg`
   - search for a function name
   - open a result
   - use `<C-o>` to jump back
3. Flash drill:
   - in a long function, jump to `return`, `if`, or an argument using `s`
   - then perform a text-object edit (`ci(`, `ci{`, `ci"`)

4. Harpoon drill:
   - In a real repo, pick 3 related files you touch together.
   - Open each with Telescope and add to Harpoon (`<leader>ha`).
   - Jump between them using `<leader>1`/`<leader>2`/`<leader>3`.
   - Why: train "working set" navigation.

## Real-code mission (60-180 minutes)

Pick a bugfix or feature.

Rules:

- All file opens must be through Telescope (no manual `:e` except in rare cases).
- All within-file "find the spot" must be Flash or search.
- Use `<C-o>`/`<C-i>` to navigate history.

## Common mistakes

- Using file tree for everything. Use Telescope when you know what you want.
- Using Telescope but then still walking with `j/k` to find the exact spot. Use Flash.
