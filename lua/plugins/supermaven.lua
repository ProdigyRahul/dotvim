return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-g>",
        clear_suggestion = "<C-]>",
        accept_word = "<M-g>",
      },
      ignore_filetypes = {
        TelescopePrompt = true,
        oil = true,
      },
      disable_inline_completion = false,
      disable_keymaps = false,
      log_level = "off",
    })
  end,
}
