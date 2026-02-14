# Chapter 15: Git Workflows (fast reviews and safe commits)

## Goal

By the end of this chapter you will:

- Use gitsigns hunks to stage/reset precisely.
- Use Fugitive for core git commands inside Neovim.
- Use Lazygit when you want a full-screen git UI.

## Why this matters

As a programmer, most "slow time" is not typing.

It's:

- reviewing changes
- staging the right pieces
- fixing mistakes quickly

Git inside Neovim keeps you in flow.

## Gitsigns (line-by-line git awareness)

Navigation:

- Next hunk: `]c`
- Previous hunk: `[c`

Actions:

- Stage hunk: `<leader>hs`
- Reset hunk: `<leader>hr`
- Preview hunk: `<leader>hp`
- Stage buffer: `<leader>hS`
- Reset buffer: `<leader>hR`
- Blame line: `<leader>hb`
- Toggle line blame: `<leader>tb`
- Diff this: `<leader>hd`

Why hunks matter:

- You can stage only the correct part of a file.

## Fugitive (git commands)

Your keymaps:

- Git status: `<leader>gs`
- Commit: `<leader>gc`
- Push: `<leader>gp`
- Pull: `<leader>gP`
- Blame: `<leader>gb`
- Diff: `<leader>gd`
- Log: `<leader>gl`

Tip: start with status and diff. Everything else comes later.

## Lazygit (full-screen git UI)

- Open Lazygit: `<leader>gg`

Use this when you want:

- interactive staging
- browsing branches
- quick commit workflows

## Drills (30-90 minutes)

Do each 5-10 times over a week.

1. Hunk staging drill:
   - Make two separate edits in a file (two hunks).
   - Stage only one using `<leader>hs`.
   - Preview before staging with `<leader>hp`.
2. Reset drill:
   - Break something intentionally.
   - Reset just the hunk with `<leader>hr`.
3. Diff drill:
   - Use `<leader>hd` or `<leader>gd` and understand what changed.

## Real-code mission (60-180 minutes)

Do one real PR-sized change using this workflow:

1. Work in code.
2. Use gitsigns to stage hunks as you go.
3. Review with diff.
4. Commit from Fugitive or Lazygit.

Rules:

- Do not stage everything blindly.
- Preview hunks before staging.

## Common mistakes

- Staging everything and discovering later that you committed junk.
- Using blame without context. Blame is useful, but diff is usually the first step.

