return {
  "Exafunction/windsurf.vim",
  event = "InsertEnter",
  config = function()
    -- Disable default keybindings to set custom ones
    vim.g.codeium_disable_bindings = 1

    -- Accept suggestion with Tab (only when suggestion visible)
    vim.keymap.set("i", "<Tab>", function()
      if vim.fn["codeium#Accept"]() ~= "" then
        return vim.fn["codeium#Accept"]()
      else
        return "<Tab>"
      end
    end, { expr = true, silent = true })

    -- Cycle through suggestions
    vim.keymap.set("i", "<M-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
    vim.keymap.set("i", "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })

    -- Clear/dismiss suggestion
    vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })

    -- Manual trigger
    vim.keymap.set("i", "<M-\\>", function() return vim.fn["codeium#Complete"]() end, { expr = true, silent = true })
  end,
}
