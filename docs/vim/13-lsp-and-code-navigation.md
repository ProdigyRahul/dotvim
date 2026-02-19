# Chapter 13: LSP and Code Navigation (programmer mode)

## Goal

By the end of this chapter you will:

- Use LSP navigation (definition, references, hover) as your default.
- Use diagnostics effectively without breaking flow.
- Use your TypeScript tooling commands to keep imports clean.

## Why this matters

Vim mastery is not only motions.

As a programmer you need:

- jump to definition instantly
- find references reliably
- understand types quickly
- rename safely

That's what LSP is for.

## Your current LSP keys (from your config)

These work in Normal mode when an LSP is attached:

- Hover docs/type: `K`
- Go to definition: `gd`
- Go to declaration: `gD`
- Go to implementation: `gi`
- References: `gr`
- Code action: `<leader>ca`
- Rename symbol: `<leader>rn`
- Format: `<leader>f`

Diagnostics:

- Prev/next diagnostic: `[d` / `]d`
- Line diagnostics float: `<leader>e`
- Diagnostics list: `<leader>q`

Check if LSP is attached:

- `:LspInfo`

## TypeScript tools (extra commands)

Your `typescript-tools.nvim` sets these in TS/JS buffers:

- Organize imports: `gs`
- Add missing imports: `ga`
- Remove unused: `gu`
- Fix all: `gF`
- Go to source definition: `gI`
- File references: `gR`
- Rename file: `<leader>rF`

## Formatting (your config)

- Format (Conform, with LSP fallback): `<leader>f`
- Alternate format key (same action): `<leader>mp`

Tip: if formatting fights you, pick one workflow and stick to it.

## Drills (use a real TS/JS file if possible)

Do each 5-10 times in a real project where TS server is running.

1. "Hover then decide":
   - Put cursor on a variable or function call.
   - Press `K`.
   - Say what you learned (type, docs, signature).
2. "Jump and return":
   - `gd` to jump to definition.
   - `<C-o>` to go back.
3. "References workflow":
   - `gr` to list references.
   - Pick one, jump, and use `<C-o>` to return.
4. "Rename safely":
   - Run `<leader>rn` on a local symbol.
   - Confirm results in 2-3 locations.

## Real-code mission (60-180 minutes)

Pick one module and do a small refactor using only LSP navigation:

- rename a function
- move code between functions
- clean imports with `gs` / `gu`

Rules:

- Use `gd` and `gr` instead of searching manually.
- Use `<C-o>` instead of "find previous file again".

## Common mistakes

- Thinking LSP is "not working" when it's just not attached.
  - Use `:LspInfo`.
- Forgetting that `K` is hover and is often faster than reading code.

## Help to read

- `:h lsp`
- `:h vim.lsp.buf`
- `:h diagnostic`
