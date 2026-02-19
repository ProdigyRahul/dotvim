return {
  "Exafunction/windsurf.vim",
  event = "InsertEnter",
  config = function()
    -- Disable default keybindings to set custom ones
    vim.g.codeium_disable_bindings = 1

    -- Accept suggestion (keeps <Tab> for nvim-cmp/snippets)
    vim.keymap.set("i", "<C-g>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })

    -- Cycle through suggestions
    vim.keymap.set("i", "<M-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })

    -- Clear/dismiss suggestion
    vim.keymap.set("i", "<C-]>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })

    -- Manual trigger
    vim.keymap.set("i", "<M-\\>", function() return vim.fn["codeium#Complete"]() end, { expr = true, silent = true })
  end,
}
