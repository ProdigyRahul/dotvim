return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle" },
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undo Tree" },
  },
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SplitWidth = 24
  end,
}