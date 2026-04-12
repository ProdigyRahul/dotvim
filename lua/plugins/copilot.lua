return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_filetypes = {
        ["*"] = true,
        TelescopePrompt = false,
        ["neo-tree"] = false,
        oil = false,
        alpha = false,
        gitcommit = false,
        gitrebase = false,
        help = false,
      }
    end,
    config = function()
      local map = vim.keymap.set

      map("i", "<C-g>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
        desc = "Copilot: accept suggestion",
      })

      map("i", "<M-Right>", "<Plug>(copilot-accept-word)", { desc = "Copilot: accept word" })
      map("i", "<M-Down>",  "<Plug>(copilot-accept-line)", { desc = "Copilot: accept line" })
      map("i", "<M-]>",     "<Plug>(copilot-next)",        { desc = "Copilot: next suggestion" })
      map("i", "<M-[>",     "<Plug>(copilot-previous)",    { desc = "Copilot: prev suggestion" })
      map("i", "<C-]>",     "<Plug>(copilot-dismiss)",     { desc = "Copilot: dismiss" })
      map("i", "<M-\\>",    "<Plug>(copilot-suggest)",     { desc = "Copilot: request suggestion" })

      map("n", "<leader>cp", "<cmd>Copilot panel<cr>",   { desc = "Copilot: open panel" })
      map("n", "<leader>ct", "<cmd>Copilot toggle<cr>",  { desc = "Copilot: toggle" })
      map("n", "<leader>cs", "<cmd>Copilot status<cr>",  { desc = "Copilot: status" })
    end,
  },
}
