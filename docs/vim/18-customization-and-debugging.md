# Chapter 18: Customization and Debugging (own your editor)

## Goal

By the end of this chapter you will:

- Debug "why did this mapping change?" problems quickly.
- Inspect options and autocmds with `:verbose`.
- Understand your config structure well enough to modify it safely.

## Why this matters

At some point you'll think:

- "This key used to do X"
- "Why is this slow?"
- "Which plugin is responsible?"

If you can debug your config, you stop being blocked.

## Your config structure (this repo)

- `init.lua` loads Lazy and then your settings/autocmds.
- Core options + keymaps: `lua/vim-settings.lua`
- Autocmds + single-buffer behavior: `lua/autocommands.lua`
- Plugins: `lua/plugins/*.lua`

## Inspecting mappings (the fastest debug tool)

Show mapping:

- `:map {lhs}` for Normal/Visual/etc
- `:nmap {lhs}` Normal only
- `:imap {lhs}` Insert only

The real tool:

- `:verbose nmap {lhs}`

It tells you *which file* last set the mapping.

## Inspecting options

Check an option:

- `:set option?` (example: `:set timeoutlen?`)

See who last set it:

- `:verbose set option?`

## Inspecting autocmds

List autocmds:

- `:autocmd`

Filter:

- `:autocmd BufEnter`

See source:

- `:verbose autocmd BufEnter`

This matters because your single-buffer logic is implemented as autocmds.

## Messages and logs

- `:messages` shows recent messages/errors.
- `:checkhealth` runs health checks (plugins may add their own).

## Safe ways to experiment

1. Make changes in small steps.
2. Restart Neovim to ensure clean state.
3. Validate with headless start:
   - `nvim --headless "+qa"`

## Drills (30-90 minutes)

Do each 5-10 times until it feels easy.

1. Find the source of a mapping:
   - run `:verbose nmap gd`
   - run `:verbose nmap <leader>gs`
2. Find the source of an option:
   - run `:verbose set hidden?`
3. Inspect autocmds:
   - run `:verbose autocmd BufEnter`
   - identify which group/file created it

## Real-code mission (60-180 minutes)

Pick one annoyance and fix it with evidence:

- a mapping conflict
- an option you want changed
- an autocmd you want adjusted

Rules:

- First: prove the cause with `:verbose ...`
- Then: change only the smallest thing to fix it
- Then: verify with `nvim --headless "+qa"`

