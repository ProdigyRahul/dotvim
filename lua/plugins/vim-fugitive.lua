return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gstatus", "Gblame", "Gpush", "Gpull", "Gcommit", "Gdiff" },
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
    vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
    vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
    vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
    vim.keymap.set("n", "<leader>gd", ":Gdiff<CR>", { desc = "Git diff" })
    vim.keymap.set("n", "<leader>gl", ":Git log --oneline<CR>", { desc = "Git log" })
  end,
}