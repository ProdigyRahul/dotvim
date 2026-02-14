# Chapter 16: Spectre and Multi-file Refactors (safe project-wide changes)

## Goal

By the end of this chapter you will:

- Use Spectre to search and replace across many files safely.
- Avoid the two classic disasters: replacing too much and replacing the wrong pattern.
- Combine Spectre with Vim skills (`.` / macros / quickfix thinking).

## Why this matters

Real refactors are multi-file:

- rename a function
- change an import path
- update an API call signature

Spectre gives you a structured UI for ripgrep results + replace operations.

## Your Spectre keymaps

From your config (`lua/plugins/nvim-spectre.lua`):

- Toggle Spectre: `<leader>S`
- Search current word: `<leader>sw` (Normal)
- Search current selection: `<leader>sw` (Visual)
- Search in current file: `<leader>sp`

Custom helpers:

- Search in directory: `<leader>sd`
- Search with file pattern: `<leader>sf`
- Replace in current file: `<leader>sr`
- Search in git repo root: `<leader>sg`

## Workflow you should follow every time

1. Start narrow:
   - begin with `<leader>sr` or `<leader>sp` if possible
2. Validate matches:
   - ensure results are only the intended occurrences
3. Only then go wide:
   - use `<leader>sd` (directory) or `<leader>sg` (repo root)
4. Replace in small batches:
   - run replace on a few items first
   - confirm build/tests still pass

## Drills (safe practice first)

Do these in a small repo or a scratch directory.

1. Rename a function call:
   - search `oldName(` -> replace `newName(`
   - verify you did not touch comments or strings unless intended
2. Import path migration:
   - replace `from "@/lib/` -> `from "@/server/lib/`
3. File pattern restriction:
   - use `<leader>sf` with pattern `**/*.ts` and ensure it ignores other files

Repeat each 5-10 times on different patterns.

## Real-code mission (2-6 hours)

Pick one real refactor.

Suggested refactors:

- rename a shared utility function and update imports
- change API route string in multiple call sites
- update env var name across the repo

Rules:

- Start with `<leader>sw` to confirm pattern in context.
- Replace in 5-20 matches, then run a quick check (lint/test/build).
- Keep a rollback path:
  - commit before refactor, or at least use `git diff` and `u` wisely

## Common mistakes (and how to avoid them)

1. Replacing inside strings/comments accidentally
   - Fix: tighten pattern (`\\<word\\>`, add surrounding tokens)
2. Replacing with the wrong casing/format
   - Fix: do 1-3 replacements first, then adjust
3. Doing too much before checking
   - Fix: batch in small steps

