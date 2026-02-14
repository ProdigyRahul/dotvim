return {
  "catppuccin/nvim",
  enabled = false,
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
